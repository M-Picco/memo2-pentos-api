require 'sinatra'
require 'json'
require_relative 'model/client.rb'
require_relative 'model/order.rb'
require_relative 'model/delivery.rb'
require_relative 'repositories/client_repository.rb'
require_relative 'repositories/order_repository.rb'
require_relative 'repositories/delivery_repository.rb'
require_relative 'errors/errors'

get '/' do
  content_type :json
  { content: 'Pentos API' }.to_json
end

post '/client' do
  content_type :json
  params = JSON.parse(request.body.read)

  client = Client.new(params)

  if ClientRepository.new.save(client)
    response = { client_id: client.id }
  else
    status 400
    response = { error: extract_first_error(client) }
  end

  response.to_json
end

post '/client/:username/order' do
  content_type :json

  client = ClientRepository.new.find_by_name(params['username'])
  order = Order.new(client: client)

  if OrderRepository.new.save(order)
    response = { order_id: order.id }
  else
    status 400
    response = { error: extract_first_error(client) }
  end

  response.to_json
end

put '/order/:order_id/status' do
  content_type :json
  body = JSON.parse(request.body.read)

  order_id = params['order_id']
  new_status = body['status']

  if OrderRepository.new.change_order_state(order_id, new_status)
    status 200
  else
    status 400
    { error: 'invalid_state_transition' }.to_json
  end
end

get '/client/:username/order/:order_id' do
  content_type :json
  username = params['username']

  if OrderRepository.new.has_orders?(username)
    order_id = params['order_id']

    order = OrderRepository.new.find_for_user(order_id, username)
    response = { order_status: order.state }
  else
    status 400
    response = { error: 'there are no orders' }
  end

  response.to_json
end

post '/delivery' do
  content_type :json
  params = JSON.parse(request.body.read)
  delivery = Delivery.new(params)

  if DeliveryRepository.new.save(delivery)
    response = { delivery_id: delivery.id }
  else
    status 400
    response = { error: 'invalid_username' }
  end

  response.to_json
end

post '/client/:username/order/:order_id/rate' do
  content_type :json
  body = JSON.parse(request.body.read)

  username = params['username']
  order_id = params['order_id']
  rating = body['rating']

  order = OrderRepository.new.find_for_user(order_id, username)
  order.rating = rating

  if OrderRepository.new.save(order)
    status 200
    response = { rating: rating }
  else
    status 400
    response = { error: extract_first_error(order) }
  end

  response.to_json
end

error OrderNotFoundError do |e|
  status 400
  { error: e.message }.to_json
end

post '/reset' do
  OrderRepository.new.delete_all
  ClientRepository.new.delete_all
  DeliveryRepository.new.delete_all
  status 200
end

def extract_first_error(entity)
  return '' if entity.errors.empty?

  # Ex: entity.errors.messages = [:symbol, ["the error"]]
  entity.errors.messages.first[1].first
end
