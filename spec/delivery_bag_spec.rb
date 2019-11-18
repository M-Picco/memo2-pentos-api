require 'spec_helper'

describe DeliveryBag do
  subject(:bag) { described_class.new() }

  describe 'model' do
    it { is_expected.to respond_to(:size) }
  end
end