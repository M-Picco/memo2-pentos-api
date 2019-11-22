require_relative 'non_rainy_weather'

class WeatherFactory
  def create_for(_weather_name)
    NonRainyWeather.new
  end
end
