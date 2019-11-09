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

def header
  { 'Content-Type' => 'application/json' }
end

def app
  Sinatra::Application
end
