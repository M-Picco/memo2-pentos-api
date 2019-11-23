require_relative '../app/model/weather/configurable_weather_service'

describe ConfigurableWeatherService do
  subject(:service) { described_class.new }

  describe 'weather' do
    it 'returns NonRainyWeather by default' do
      weather = service.weather

      expect(weather).to be_a(NonRainyWeather)
    end
  end

  describe 'raining' do
    it 'returns RainyWeather after calling raining' do
      service.raining(true)

      weather = service.weather

      expect(weather).to be_a(RainyWeather)
    end
  end

  describe 'set_not_raining' do
    it 'returns NonRainyWeather after calling raining and then calling set_not_raining' do
      service.raining(true)
      service.raining(false)

      weather = service.weather

      expect(weather).to be_a(NonRainyWeather)
    end
  end
end
