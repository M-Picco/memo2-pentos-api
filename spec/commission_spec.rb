require 'spec_helper'

describe Commission do
  subject(:commision) { described_class.new(100) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:order_cost) }
  end

  describe 'ammount' do
    it 'should be 5 when order cost is 100' do
      commision = described_class.new(100)
      expect(commision.amount).to eq(5)
    end
  end
end
