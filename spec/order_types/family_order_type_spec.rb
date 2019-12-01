require 'spec_helper'
require_relative '../../app/order_types/family_order'

describe FamilyOrderType do
  subject(:type) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:type_name) }
    it { is_expected.to respond_to(:size) }
    it { is_expected.to respond_to(:cost) }
    it { is_expected.to respond_to(:base_time) }
  end

  describe 'create' do
    # rubocop:disable RSpec/MultipleExpectations
    it 'created with correct attributes values' do
      expect(type.type_name).to eq ORDERTYPES::FAMILY_ORDER
      expect(type.size).to eq ORDERSIZE::FAMILY_ORDER
      expect(type.cost).to eq ORDERCOSTS::FAMILY_ORDER
      expect(type.base_time).to eq ORDERBASETIME::FAMILY_ORDER
    end
    # rubocop:enable RSpec/MultipleExpectations
  end
end
