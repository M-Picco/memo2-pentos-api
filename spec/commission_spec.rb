require 'spec_helper'

describe Commission do
  subject(:commision) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:amount) }
  end
end
