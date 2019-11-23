require 'integration_spec_helper'

describe OrderHelper do
  let(:helper) { described_class.new }

  describe 'parse' do
    it 'should return a empty hash if order is nil' do
      order_parse = helper.parse(nil)

      expect(order_parse).to eq({})
    end
  end
end
