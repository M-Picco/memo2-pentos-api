source 'https://rubygems.org'

ruby '2.5.1'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Server requirements
gem 'thin'

# Project requirements
gem 'rake'

# Sinatra
gem 'sinatra'

# Component requirements
gem 'activemodel', require: 'active_model'
gem 'faraday'
gem 'json'
gem 'pg', '~> 0.18'
gem 'sequel'

group :development, :test do
  gem 'cucumber'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'byebug'
  gem 'guard'
  gem 'guard-rspec'
end
