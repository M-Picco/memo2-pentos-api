require 'spec_helper'

describe Commission do
  subject(:commision) { described_class.new({ order_cost: 100 }, default_weather) }

  let(:default_weather) { NonRainyWeather.new }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:order_cost) }
    it { is_expected.to respond_to(:updated_on) }
    it { is_expected.to respond_to(:created_on) }
    it { is_expected.to respond_to(:weather) }
  end

  describe 'creation' do
    it 'should de valid when order_cost is positive number' do
      commision = described_class.new({ order_cost: 100 }, default_weather)
      expect(commision.valid?).to eq true
      expect(commision.errors.empty?).to eq true
    end

    it 'should de valid when order_cost is blank is replaced by zero' do
      commision = described_class.new({}, default_weather)
      expect(commision.valid?).to eq true
      expect(commision.errors.empty?).to eq true
      expect(commision.order_cost.zero?).to eq true
    end

    it 'should raise InvalidParameterError when order_cost is negative number' do
      expect do
        described_class.new({ order_cost: -1 }, default_weather)
      end.to raise_error('invalid_cost')
    end
  end

  describe 'non rainy weather' do
    describe 'amount' do
      it 'should be 5 when order cost is 100' do
        commision = described_class.new({ order_cost: 100 }, default_weather)
        expect(commision.amount).to eq(5)
      end

      it 'should be 5% of the order cost' do
        order_cost = 200
        commision = described_class.new({ order_cost: order_cost }, default_weather)
        expect(commision.amount).to eq(order_cost * 0.05)
      end
    end

    describe 'update amount by rating' do
      it 'amount does not change from 6% if rating is 3' do
        order_cost = 100
        commision = described_class.new({ order_cost: order_cost }, default_weather)
        commision.update_by_rating(3)
        expect(commision.amount).to eq(order_cost * 0.05)
      end

      it 'amount changes to 3% if rating is 1' do
        order_cost = 100
        commision = described_class.new({ order_cost: order_cost }, default_weather)
        commision.update_by_rating(1)
        expect(commision.amount).to eq(order_cost * 0.03)
      end

      it 'amount changes to 7% if rating is 5' do
        order_cost = 100
        commision = described_class.new({ order_cost: order_cost }, default_weather)
        commision.update_by_rating(5)
        expect(commision.amount).to eq((order_cost * 0.07).round(2))
      end
    end
  end

  describe 'rainy weather' do
    let(:rainy_weather) { RainyWeather.new }

    describe 'amount' do
      it 'should be 6 when order cost is 100' do
        commision = described_class.new({ order_cost: 100 }, rainy_weather)
        expect(commision.amount).to eq(6)
      end

      it 'should be 6% of the order cost' do
        order_cost = 200
        commision = described_class.new({ order_cost: order_cost }, rainy_weather)
        expect(commision.amount).to eq(order_cost * 0.06)
      end
    end

    describe 'update amount by rating' do
      it 'amount does not change from 6% if rating is 3' do
        order_cost = 100
        commision = described_class.new({ order_cost: order_cost }, rainy_weather)
        commision.update_by_rating(3)
        expect(commision.amount).to eq(order_cost * 0.06)
      end

      it 'amount changes to 4% if rating is 1' do
        order_cost = 100
        commision = described_class.new({ order_cost: order_cost }, rainy_weather)
        commision.update_by_rating(1)
        expect(commision.amount).to eq(order_cost * 0.04)
      end

      it 'amount changes to 8% if rating is 5' do
        order_cost = 100
        commision = described_class.new({ order_cost: order_cost }, rainy_weather)
        commision.update_by_rating(5)
        expect(commision.amount).to eq(order_cost * 0.08)
      end
    end
  end
end
