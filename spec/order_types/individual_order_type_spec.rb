require 'spec_helper'
require_relative '../../app/order_types/individual_order'

describe IndividualOrderType do
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
      expect(type.type_name).to eq 'menu_individual'
      expect(type.size).to eq 1
      expect(type.cost).to eq 100
      expect(type.base_time).to eq 10
    end
    # rubocop:enable RSpec/MultipleExpectations
  end
end
