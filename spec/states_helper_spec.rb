require 'spec_helper'
require_relative '../app/helpers/states_helper'
require_relative '../app/states/recieved_state'
require_relative '../app/states/inpreparation_state'

describe StatesHelper do
  describe 'create for' do
    it 'should return RecievedState class when I pass "recibido"' do
      return_state = described_class.create_for('recibido')
      expect(return_state).to eq(RecievedState.new)
    end

    it 'should return InPreparationState class when I pass "en_preparacion"' do
      return_state = described_class.create_for('en_preparacion')
      expect(return_state).to eq(InPreparationState.new)
    end
  end
end
