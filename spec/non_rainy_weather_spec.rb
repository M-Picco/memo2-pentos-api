require 'spec_helper'
require_relative '../app/model/weather/non_rainy_weather'

describe NonRainyWeather do
  subject(:weather) { described_class.new }

  describe 'name' do
    it 'has name "no_lluvioso"' do
      expect(weather.name).to eq('no_lluvioso')
    end
  end

  describe 'apply_commission_modifier' do
    it 'applies the commission modifier of 0%' do
      com = 1.05

      final_com = weather.apply_commission_modifier(com)

      expect(final_com).to eq(com)
    end
  end
end
