require 'spec_helper'

describe DeliveryBag do
  subject(:bag) { described_class.new }

  let(:client) do
    Client.new('username' => 'jperez', 'phone' => '4123-4123',
               'address' => 'Av Paseo Colón 840')
  end

  let(:order_familiar) { Order.new(client: client, type: 'menu_familiar') }
  let(:order_pareja) { Order.new(client: client, type: 'menu_pareja') }
  let(:order_indivual) { Order.new(client: client, type: 'menu_individual') }

  describe 'model' do
    it { is_expected.to respond_to(:size) }
  end

  it 'initial size' do
    expect(bag.size).to eq(3)
  end

  describe 'load orders' do
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

    it 'should load an empty collection' do
      orders = []
      bag.load_orders_from_collection(orders)
      expect(bag.size).to eq(3)
    end

    it 'should load a single order from a collection' do
      orders = [order_indivual]
      bag.load_orders_from_collection(orders)
      expect(bag.size).to eq(2)
    end

    it 'should load orders from a collection' do
      orders = [order_indivual, order_pareja]
      bag.load_orders_from_collection(orders)
      expect(bag.size).to eq(0)
    end
  end

  describe 'Bag fitting' do
    it 'should fit an empty bag and a menu_familiar order' do
      expect(bag.fits?(order_familiar)).to eq(true)
    end

    it 'should not fit a bag with a menu_familiar and menu_indivual' do
      bag.load_order(order_familiar)
      expect(bag.fits?(order_indivual)).to eq(false)
    end
  end
end
