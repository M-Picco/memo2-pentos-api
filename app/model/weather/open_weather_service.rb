require 'faraday'
require 'json'

class OpenWeatherService
  API_URL = 'http://api.openweathermap.org/data/2.5/weather?id=%d&appid=%s'.freeze
  BUENOS_AIRES_CITY_ID = 3_433_955

  def initialize(api_key = ENV['WEATHER_API_KEY'])
    @api_key = api_key
  end

  def weather
    final_url = format(API_URL, BUENOS_AIRES_CITY_ID, @api_key)

    response = Faraday.get final_url
    json = JSON.parse(response.body)

    weather = json['weather'].first['main']

    WeatherFactory.new.create_for(map_weather(weather))
  end

  # https://openweathermap.org/weather-conditions
  def map_weather(weather)
    return 'lluvioso' if %w[Drizzle Rain].include?(weather)

    'no_lluvioso'
  end
end
