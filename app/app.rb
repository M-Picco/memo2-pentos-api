require 'sinatra'
require 'json'
require_relative 'model/client.rb'
require_relative 'model/order.rb'
require_relative 'model/delivery.rb'
require_relative 'repositories/client_repository.rb'
require_relative 'repositories/order_repository.rb'
require_relative 'repositories/delivery_repository.rb'
require_relative 'errors/order_not_found_error'
require_relative 'errors/invalid_menu_error'
require_relative 'errors/client_has_no_orders_error'
require_relative 'errors/failed_save_operation_error'
require_relative 'helpers/states_helper'

KNOWN_ERRORS = [OrderNotFoundError, ClientHasNoOrdersError,
                InvalidMenuError, FailedSaveOperationError,
                ClientNotFoundError].freeze

get '/' do
  content_type :json
  { content: 'Pentos API' }.to_json
end

post '/client' do
  content_type :json
  params = JSON.parse(request.body.read)

  client = Client.new(params)

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
  new_status = StatesHelper.create_for(body['status'])

  repository = OrderRepository.new

  order = repository.find_by_id(order_id)
  order.state = new_status

  raise FailedSaveOperationError, order unless repository.save(order)

  status 200
end

get '/client/:username/order/:order_id' do
  content_type :json
  username = params['username']

  raise ClientNotFoundError unless ClientRepository.new.exists?(username)
  raise ClientHasNoOrdersError unless OrderRepository.new.has_orders?(username)

  order_id = params['order_id']

  order = OrderRepository.new.find_for_user(order_id, username)
  response = { order_status: order.state.state_name,
               assigned_to: order.assigned_to }

  response.to_json
end

post '/delivery' do
  content_type :json
  params = JSON.parse(request.body.read)
  delivery = Delivery.new(params)

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

post '/commission/:order_id' do
  content_type :json
  order_id = params['order_id']

  order = OrderRepository.new.find(order_id)

  { commission_amount: order.commission.amount }.to_json
end

post '/weather' do
end

error(*KNOWN_ERRORS) do |e|
  status 400
  { error: e.message }.to_json
end

# test environment methods
if settings.environment != :production
  post '/reset' do
    OrderRepository.new.delete_all
    ClientRepository.new.delete_all
    DeliveryRepository.new.delete_all
    status 200
  end
end
