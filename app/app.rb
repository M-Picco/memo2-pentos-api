require 'sinatra'
require 'json'

get '/' do
  content_type :json
  { content: 'Pentos API' }.to_json
end

post 'client' do
end
