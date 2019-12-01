require 'spec_helper'

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

    it 'fails to create an order type without a type name' do
      expect { factory.create_for(nil) }
        .to raise_error(ERRORS::INVALID_MENU)
    end

    it 'fails to create an order type with an invalid type name' do
      expect { factory.create_for('menu_invalido') }
        .to raise_error(ERRORS::INVALID_MENU)
    end
  end
end
