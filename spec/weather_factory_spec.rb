require 'spec_helper'
require_relative '../app/model/weather/weather_factory'

describe WeatherFactory do
  subject(:factory) { described_class.new }

  describe 'create for' do
    it 'should return NonRainyWeather for "no_lluvioso"' do
      weather = factory.create_for('no_lluvioso')
      expect(weather).to be_a(NonRainyWeather)
    end
  end
end
