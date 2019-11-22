require 'spec_helper'
require_relative '../app/states/state_factory'
require_relative '../app/states/recieved_state'
require_relative '../app/states/inpreparation_state'
require_relative '../app/states/ondelivery_state'
require_relative '../app/states/delivered_state'
require_relative '../app/states/invalid_state'

describe StateFactory do
  subject(:factory) { described_class.new }

  describe 'create for' do
    it 'should return RecievedState class when I pass "recibido"' do
      return_state = factory.create_for('recibido')
      expect(return_state).to eq(RecievedState.new)
    end

    it 'should return InPreparationState class when I pass "en_preparacion"' do
      return_state = factory.create_for('en_preparacion')
      expect(return_state).to eq(InPreparationState.new)
    end

    it 'should return OnDeliveryState class when I pass "en_entrega"' do
      return_state = factory.create_for('en_entrega')
      expect(return_state).to eq(OnDeliveryState.new)
    end

    it 'should return DeliveredState class when I pass "entregado"' do
      return_state = factory.create_for('entregado')
      expect(return_state).to eq(DeliveredState.new)
    end

    it 'should return InvalidState class when I pass "invalid_state"' do
      return_state = factory.create_for('invalid_state')
      expect(return_state).to eq(InvalidState.new)
    end

    it 'should return InvalidState class when I pass "invalid_name"' do
      return_state = factory.create_for('invalid_name')
      expect(return_state).to eq(InvalidState.new)
    end
  end
end