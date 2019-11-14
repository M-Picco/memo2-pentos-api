require 'spec_helper'

describe Delivery do
  subject(:delivery) { described_class.new('username') }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:username) }
  end
end
