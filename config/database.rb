require 'sequel'
require 'sinatra'

Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure

env = Sinatra::Application.settings.environment

DB =
  case env
  when :development
    Sequel.connect('postgres://pentosapi:pentosapi@localhost/pentosapi_development')
  when :test
    test_db_host = ENV['DB_HOST'] || 'localhost'
    Sequel.connect("postgres://pentosapi:pentosapi@#{test_db_host}/pentosapi_test")
  when :staging
    Sequel.connect(ENV['DATABASE_URL'])
  when :production
    Sequel.connect(ENV['DATABASE_URL'])
  end
