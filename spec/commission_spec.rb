require 'spec_helper'

describe Commission do
  subject(:commision) { described_class.new(order_cost: 100) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:order_cost) }
    it { is_expected.to respond_to(:updated_on) }
    it { is_expected.to respond_to(:created_on) }
  end

  describe 'valid?' do
    it 'should de valid when order_cost is positive number' do
      commision = described_class.new(order_cost: 100)
      expect(commision.valid?).to eq true
      expect(commision.errors.empty?).to eq true
    end

    it 'should de valid when order_cost is blank is replaced by zero' do
      commision = described_class.new
      expect(commision.valid?).to eq true
      expect(commision.errors.empty?).to eq true
    end

    it 'should de invalid when order_cost is negative number' do
      commision = described_class.new(order_cost: -1)
      expect(commision.valid?).to eq false
      expect(commision.errors).to have_key(:order_cost)
    end
  end

  describe 'amount' do
    it 'should be 5 when order cost is 100' do
      commision = described_class.new(order_cost: 100)
      expect(commision.amount).to eq(5)
    end

    it 'should be 5% of the order cost' do
      order_cost = 200
      commision = described_class.new(order_cost: order_cost)
      expect(commision.amount).to eq(order_cost * 0.05)
    end
  end

  describe 'update amount by rating' do
    it 'amount dont change if rating is 3' do
      order_cost = 100
      commision = described_class.new(order_cost: order_cost)
      commision.update_by_rating(3)
      expect(commision.amount).to eq(order_cost * 0.05)
    end

    it 'amount change to 3% if rating is 1' do
      order_cost = 100
      commision = described_class.new(order_cost: order_cost)
      commision.update_by_rating(1)
      expect(commision.amount).to eq(order_cost * 0.03)
    end
  end
end
