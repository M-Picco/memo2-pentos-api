require 'sinatra'
require 'json'
require_relative 'model/client.rb'
require_relative 'model/order.rb'
require_relative 'repositories/client_repository.rb'
require_relative 'repositories/order_repository.rb'

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
    response response = { error: extract_first_error(client) }
  end

  response.to_json
end

post '/reset' do
  ClientRepository.new.delete_all
  status 200
end

def extract_first_error(entity)
  return '' if entity.errors.empty?

  # Ex: entity.errors.messages = [:symbol, ["the error"]]
  entity.errors.messages.first[1].first
end
