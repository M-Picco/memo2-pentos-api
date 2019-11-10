require 'spec_helper'

describe Order do
  subject(:order) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:client) }
    it { is_expected.to respond_to(:state) }
  end

  describe 'state' do
    it 'has "received" as initial value' do
      expect(order.state).to eq('recibido')
    end

    it 'is invalid when changing to an invalid state' do
      order.state = 'not_contemplated_state'

      expect(order.state).to eq('invalid_state')
      expect(order.valid?).to eq(false)
    end
  end
end
