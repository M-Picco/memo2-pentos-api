require 'sinatra'
require 'json'
require_relative 'model/client.rb'
require_relative 'model/order.rb'
require_relative 'model/delivery.rb'
require_relative 'repositories/client_repository.rb'
require_relative 'repositories/order_repository.rb'
require_relative 'repositories/delivery_repository.rb'
require_relative 'errors/order_not_found_error'
require_relative 'errors/order_not_delivered_error'
require_relative 'errors/invalid_menu_error'
require_relative 'errors/client_has_no_orders_error'
require_relative 'errors/failed_save_operation_error'
require_relative 'errors/already_registered_error'
require_relative 'errors/order_not_cancellable_error'
require_relative 'errors/domain_error'
require_relative 'states/state_factory'
require_relative 'states/delivered_state'
require_relative 'model/weather/configurable_weather_service'
require_relative 'model/weather/open_weather_service'
require_relative 'helpers/order_helper'
require_relative 'model/time_estimator'

API_KEY = ENV['API_KEY'] || 'zaraza'

WEATHER_SERVICE =
  settings.environment == :production ? OpenWeatherService.new : ConfigurableWeatherService.new

before do
  pass if request.path_info == '/reset'

  key = request.env['api-key'] || request.env['HTTP_API_KEY']
  halt 403, { message: 'api-key missing or incorrect' }.to_json if key != API_KEY
end

get '/' do
  content_type :json
  { content: 'Pentos API' }.to_json
end

post '/client' do
  content_type :json
  params = JSON.parse(request.body.read)

  raise AlreadyRegisteredError if ClientRepository.new.exists?(params['username'])

  client = Client.new(username: params['username'],
                      phone: params['phone'],
                      address: params['address'])

  raise FailedSaveOperationError, client unless ClientRepository.new.save(client)

  { client_id: client.id }.to_json
end

post '/client/:username/order' do
  content_type :json

  body = JSON.parse(request.body.read)

  client = ClientRepository.new.find_by_name(params['username'])
  order = Order.new(client: client, type: body['order'])

  raise FailedSaveOperationError, order unless OrderRepository.new.save(order)

  { order_id: order.id }.to_json
end

put '/order/:order_id/status' do
  content_type :json
  body = JSON.parse(request.body.read)

  order_id = params['order_id']

  weather = WEATHER_SERVICE.weather
  new_status = StateFactory.new(weather).create_for(body['status'])

  repository = OrderRepository.new

  order = repository.find_by_id(order_id)
  order.change_state(new_status)

  raise FailedSaveOperationError, order unless repository.save(order)

  status 200
end

get '/client/:username/order/:order_id' do
  content_type :json
  username = params['username']

  raise ClientNotFoundError unless ClientRepository.new.exists?(username)
  raise ClientHasNoOrdersError unless OrderRepository.new.has_orders?(username)

  weather = WEATHER_SERVICE.weather
  order_id = params['order_id']

  order = OrderRepository.new.find_for_user(order_id, username)
  response = { order_status: order.state.state_name,
               assigned_to: order.assigned_to,
               estimated_delivery_time: TimeEstimator.new.estimate(order, weather) }

  response.to_json
end

post '/delivery' do
  content_type :json
  params = JSON.parse(request.body.read)

  raise AlreadyRegisteredError if DeliveryRepository.new.exists?(params['username'])

  delivery = Delivery.new(username: params['username'])

  raise FailedSaveOperationError, delivery unless DeliveryRepository.new.save(delivery)

  status 200
  { delivery_id: delivery.id }.to_json
end

post '/client/:username/order/:order_id/rate' do
  content_type :json
  body = JSON.parse(request.body.read)

  username = params['username']
  order_id = params['order_id']
  rating = body['rating']

  raise ClientNotFoundError unless ClientRepository.new.exists?(username)
  raise ClientHasNoOrdersError unless OrderRepository.new.has_orders?(username)

  order = OrderRepository.new.find_for_user(order_id, username)
  order.rating = rating

  raise FailedSaveOperationError, order unless OrderRepository.new.save(order)

  { rating: rating }.to_json
end

get '/commission/:order_id' do
  content_type :json
  order_id = params['order_id']

  order = OrderRepository.new.find_by_id(order_id)

  { commission_amount: order.commission.amount }.to_json
end

put '/order/:order_id/cancel' do
  content_type :json
  order_id = params['order_id']

  repository = OrderRepository.new

  order = repository.find_by_id(order_id)
  order.cancel
  repository.save(order)

  status 200
end

def parse_historical(orders)
  orders.map do |order|
    OrderHelper.new.parse(order)
  end
end

error DomainError do |e|
  status 400
  { error: e.message }.to_json
end

# test environment methods
if settings.environment != :production
  post '/reset' do
    OrderRepository.new.delete_all
    ClientRepository.new.delete_all
    DeliveryRepository.new.delete_all
    WEATHER_SERVICE.raining(false)
    status 200
  end

  post '/weather' do
    status 200
    body = JSON.parse(request.body.read)

    WEATHER_SERVICE.raining(body['rain'])
  end

  get '/client/:username/historical' do
    status 200
    client_username = params['username']

    orders = OrderRepository.new.historical_orders(client_username)
    historical_orders = parse_historical(orders)

    historical_orders.to_json
  end

  put '/order/:order_id/delivered_on_time' do
    status 200
    order_id = params['order_id']
    body = JSON.parse(request.body.read)
    minutes = body['minutes']

    order = OrderRepository.new.find_by_id(order_id)
    order.change_state(DeliveredState.new)
    order.delivered_on = order.created_on + (60 * minutes)

    OrderRepository.new.save(order)
  end

  put '/delivery/:username/waiting_time' do
    content_type :json
    status 200
    username = params['username']
    body = JSON.parse(request.body.read)
    minutes = body['minutes']

    order = OrderRepository.new.last_on_delivery_by(username)
    order.on_delivery_time = order.on_delivery_time - (minutes * 60)

    OrderRepository.new.save(order)
  end
end
