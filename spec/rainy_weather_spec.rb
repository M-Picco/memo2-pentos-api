require 'spec_helper'
require_relative '../app/model/weather/rainy_weather'

describe RainyWeather do
  subject(:weather) { described_class.new }

  describe 'name' do
    it 'has name "lluvioso"' do
      expect(weather.name).to eq('lluvioso')
    end
  end

  describe 'apply_modifier' do
    it 'applies the commission modifier of 1%' do
      com = 1.05

      final_com = weather.apply_modifier(com)

      expect(final_com).to eq(1.06)
    end
  end
end
