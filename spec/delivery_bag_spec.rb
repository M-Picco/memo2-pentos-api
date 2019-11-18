require 'spec_helper'

describe DeliveryBag do
  subject(:bag) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:size) }
  end

  it 'initial size' do
    expect(bag.size).to eq(3)
  end

  describe 'load orders' do
    let(:order_indivual) { Order.new(client: client, type: 'menu_individual') }
    let(:order_pareja) { Order.new(client: client, type: 'menu_pareja') }
    let(:order_familiar) { Order.new(client: client, type: 'menu_familiar') }

    let(:client) do
      Client.new('username' => 'jperez', 'phone' => '4123-4123',
                 'address' => 'Av Paseo Colón 840')
    end

    it '"menu_indivual" should decrease bags size by 1' do
      bag.load_order(order_indivual)
      expect(bag.size).to eq(2)
    end

    it '"menu_pareja" should decrease bags size by 1' do
      bag.load_order(order_pareja)
      expect(bag.size).to eq(1)
    end

    it '"menu_familiar" should decrease bags size by 1' do
      bag.load_order(order_familiar)
      expect(bag.size).to eq(0)
    end
  end
end
