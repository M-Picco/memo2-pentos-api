require 'spec_helper'
require_relative '../app/model/weather/weather_factory'

describe WeatherFactory do
  subject(:factory) { described_class.new }

  describe 'create for' do
    it 'should return NonRainyWeather for "no_lluvioso"' do
      weather = factory.create_for('no_lluvioso')
      expect(weather).to be_a(NonRainyWeather)
    end

    it 'should return RainyWeather for "lluvioso"' do
      weather = factory.create_for('lluvioso')
      expect(weather).to be_a(RainyWeather)
    end

    it 'should return NonRainyWeather as default' do
      weather = factory.create_for('')
      expect(weather).to be_a(NonRainyWeather)
    end
  end
end
