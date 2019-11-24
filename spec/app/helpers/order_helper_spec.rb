require 'integration_spec_helper'

describe OrderHelper do
  let(:helper) { described_class.new }
  let(:order) do
    client = Client.new('username' => 'jperez', 'phone' => '4123-4123',
                        'address' => 'Av Paseo Colón 840')
    ClientRepository.new.save(client)
    order = Order.new(client: client, type: 'menu_individual')
    OrderRepository.new.save(order)

    OrderRepository.new.find_by_id(order.id)
  end

  describe 'parse' do
    it 'should return a empty hash if order is nil' do
      order_parse = helper.parse(nil)

      expect(order_parse).to eq({})
    end

    it 'should return hash with id information' do
      order_parse = helper.parse(order)
      expect(order_parse.key?(:id)).to eq true
      expect(order_parse[:id]).to eq order.id
    end

    it 'should return hash with menu information' do
      order_parse = helper.parse(order)
      expect(order_parse.key?(:menu)).to eq true
      expect(order_parse[:menu]).to eq order.type
    end

    it 'should return hash with assigned information' do
      order_parse = helper.parse(order)
      expect(order_parse.key?(:assigned_to)).to eq true
      expect(order_parse[:assigned_to]).to eq order.assigned_to
    end

    it 'should return hash with created date information' do
      order_parse = helper.parse(order)
      expect(order_parse.key?(:date)).to eq true
      expect(order_parse[:date]).to eq order.created_on.to_date.to_s
    end
  end
end
