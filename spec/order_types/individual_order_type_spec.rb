require 'spec_helper'
require_relative '../../app/order_types/individual_order'

describe IndividualOrderType do
  subject(:type) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:type_name) }
    it { is_expected.to respond_to(:cost) }
    it { is_expected.to respond_to(:base_time) }
  end
end
