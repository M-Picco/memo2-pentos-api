require 'spec_helper'
require_relative '../../app/order_types/order_type_factory'
require_relative '../../app/order_types/individual_order'
require_relative '../../app/order_types/couple_order'

describe OrderTypeFactory do
  subject(:factory) { described_class.new }

  describe 'create for' do
    it 'should return IndividualOrderType class when I pass "menu_individual"' do
      return_type = factory.create_for('menu_individual')
      expect(return_type).to be_a(IndividualOrderType)
    end

    it 'should return CoupleOrderType class when I pass "menu_pareja"' do
      return_type = factory.create_for('menu_pareja')
      expect(return_type).to be_a(CoupleOrderType)
    end

    it 'should return FamilyOrderType class when I pass "menu_familiar"' do
      return_type = factory.create_for('menu_familiar')
      expect(return_type).to be_a(FamilyOrderType)
    end
  end
end
