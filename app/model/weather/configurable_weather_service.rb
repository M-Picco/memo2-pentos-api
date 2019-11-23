require_relative './non_rainy_weather'

class ConfigurableWeatherService
  def initialize
    @weather = NonRainyWeather.new
  end

  attr_reader :weather

  def raining(raining)
    @weather = raining ? RainyWeather.new : NonRainyWeather.new
  end
end
