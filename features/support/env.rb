require 'rspec/expectations'
require 'rspec'
require 'rack/test'
require 'rspec/expectations'
require 'faraday'
require 'json'
require_relative '../../app/app'

include Rack::Test::Methods # rubocop:disable Style/MixinUsage:

BASE_URL = ENV['BASE_URL'] || 'http://localhost:4567'

CLIENT_BASE_URL = BASE_URL + '/client'
ORDER_BASE_URL = CLIENT_BASE_URL + '/%s/order'
QUERY_ORDER_URL = BASE_URL + '/order'

def query_order_status_url(username, order_id)
  CLIENT_BASE_URL + "/#{username}/order/#{order_id}"
end

def change_order_status_url(order_id)
  BASE_URL + "/order/#{order_id}/status"
end

def header
  { 'Content-Type' => 'application/json' }
end

def app
  Sinatra::Application
end
