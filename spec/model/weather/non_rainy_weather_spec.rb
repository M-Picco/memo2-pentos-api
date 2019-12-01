require 'spec_helper'

describe NonRainyWeather do
  subject(:weather) { described_class.new }

  describe 'name' do
    it 'has name "no_lluvioso"' do
      expect(weather.name).to eq('no_lluvioso')
    end
  end

  describe 'apply_modifier' do
    it 'applies the commission modifier of 0%' do
      com = 1.05

      final_com = weather.apply_modifier(com)

      expect(final_com).to eq(com)
    end
  end
end
