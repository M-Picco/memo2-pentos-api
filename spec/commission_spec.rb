require 'spec_helper'

describe Commission do
  subject(:commision) { described_class.new(100) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:order_cost) }
  end
end
