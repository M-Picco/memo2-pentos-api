require_relative 'non_rainy_weather'
require_relative 'rainy_weather'

class WeatherFactory
  def create_for(weather_name)
    return RainyWeather.new if weather_name == 'lluvioso'

    NonRainyWeather.new
  end
end
