require 'sinatra'
require 'json'
require_relative 'model/client.rb'
require_relative 'repositories/client_repository.rb'

get '/' do
  content_type :json
  { content: 'Pentos API' }.to_json
end

post '/client' do
  content_type :json
  params = JSON.parse(request.body.read)

  client = Client.new(params)
  ClientRepository.new.save(client)

  response = { client_id: client.id }
  status 200

  response.to_json
end

post '/reset' do
  ClientRepository.new.delete_all
  status 200
end