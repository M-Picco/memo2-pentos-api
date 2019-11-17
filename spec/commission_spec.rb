require 'spec_helper'

describe Commission do
  subject(:commision) { described_class.new('order_cost' => 100) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:order_cost) }
  end

  describe 'valid?' do
    it 'should de valid when order_cost is positive number' do
      commision = described_class.new
      expect(commision.valid?).to eq true
      expect(commision.errors.empty?).to eq true
    end
  end

  describe 'ammount' do
    it 'should be 5 when order cost is 100' do
      commision = described_class.new('order_cost' => 100)
      expect(commision.amount).to eq(5)
    end

    it 'should be 5% of the order cost' do
      order_cost = 200
      commision = described_class.new('order_cost' => order_cost)
      expect(commision.amount).to eq(order_cost * 0.05)
    end
  end
end
