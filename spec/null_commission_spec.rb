require 'spec_helper'

describe NullCommission do
  subject(:commision) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:amount) }
  end

  describe 'amount' do
    it 'should raise an OrderNotDeliveredError' do
      expect { commision.amount }.to raise_error(OrderNotDeliveredError)
    end
  end
end
