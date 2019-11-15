require 'spec_helper'

describe Order do
  subject(:order) { described_class.new(client: client, type: 'menu_individual') }

  let(:client) do
    Client.new('username' => 'jperez', 'phone' => '4123-4123',
               'address' => 'Av Paseo Colón 840')
  end

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:client) }
    it { is_expected.to respond_to(:state) }
    it { is_expected.to respond_to(:rating) }
    it { is_expected.to respond_to(:type) }
  end

  describe 'type' do
    it 'can be created with a menu_individual type' do
      order = described_class.new(client: client, type: 'menu_individual')
      expect(order.type).to eq('menu_individual')
    end

    it 'fails to create an order without a type' do
      expect { described_class.new(client: client) }
        .to raise_error(InvalidMenuError)
    end

    it 'fails to create an order with an invalid type' do
      expect { described_class.new(client: client, type: 'menu_invalido') }
        .to raise_error(InvalidMenuError)
    end
  end

  describe 'state' do
    it 'has "received" as initial value' do
      expect(order.state).to eq('recibido')
    end

    it 'allows in_preparation state' do
      order.state = 'en_preparacion'

      expect(order.state).to eq('en_preparacion')
      expect(order.valid?).to eq(true)
    end

    it 'allows delivery state' do
      order.state = 'en_entrega'

      expect(order.state).to eq('en_entrega')
      expect(order.valid?).to eq(true)
    end

    it 'allows delivered state' do
      order.state = 'entregado'

      expect(order.state).to eq('entregado')
      expect(order.valid?).to eq(true)
    end

    it 'is invalid when changing to an invalid state' do
      order.state = 'not_contemplated_state'

      expect(order.state).to eq('invalid_state')
      expect(order.valid?).to eq(false)
    end
  end

  describe 'rating' do
    it 'is valid when no rating' do
      expect(order.rating).to be_nil
      expect(order.valid?).to eq(true)
    end

    it 'is valid when rating with 3' do
      order.state = 'entregado'

      order.rating = 3

      expect(order.rating).to eq(3)
      expect(order.valid?).to eq(true)
    end

    it 'is invalid when rating an order in received state' do
      order.rating = 3

      expect(order.rating).to eq(3)
      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('order_not_delivered')
    end

    it 'is invalid when rating an order in in_preparation state' do
      order.state = 'en_preparacion'

      order.rating = 3

      expect(order.rating).to eq(3)
      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('order_not_delivered')
    end

    it 'is invalid when rating an order in delivering state' do
      order.state = 'en_entrega'

      order.rating = 3

      expect(order.rating).to eq(3)
      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('order_not_delivered')
    end

    it 'is invalid to rate an order with a value 1' do
      order.state = 'entregado'

      order.rating = -1

      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('invalid_rating')
    end

    it 'is invalid to rate an order with a value 6' do
      order.state = 'entregado'

      order.rating = 6

      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('invalid_rating')
    end
  end
end
