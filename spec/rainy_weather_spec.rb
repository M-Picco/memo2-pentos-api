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

  describe 'apply time modifier' do
    it 'applies the time modifier of 5 minutes' do
      time = 20

      final_time = weather.apply_time_modifier(time)

      expect(final_time).to eq(time + 5)
    end
  end
end
