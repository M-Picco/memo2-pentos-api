require 'spec_helper'
require_relative '../../app/order_types/order_type_factory'
require_relative '../../app/order_types/individual_order'

describe OrderTypeFactory do
  subject(:factory) { described_class.new }

  describe 'create for' do
    it 'should return IndividualOrderType class when I pass "menu_individual"' do
      return_type = factory.create_for('menu_individual')
      expect(return_type).to be_a(IndividualOrderType)
    end
  end
end
