require 'spec_helper'
require_relative '../app/helpers/states_helper'
require_relative '../app/states/recieved_state'

describe StatesHelper do
  describe 'create for' do
    it 'should return Recibido class when i pass "recibido"' do
      return_state = described_class.create_for('recibido')
      expect(return_state).to eq(RecievedState.new)
    end
  end
end
