require 'rspec/expectations'
require 'rspec'
require 'rack/test'
require 'rspec/expectations'
require 'faraday'
require 'json'
require_relative '../../app/app'

include Rack::Test::Methods # rubocop:disable Style/MixinUsage:

def app
  Sinatra::Application
end
