require 'spec_helper'
require_relative '../app/helpers/states_helper'
require_relative '../app/states/recieved_state'
require_relative '../app/states/inpreparation_state'
require_relative '../app/states/ondelivery_state'
require_relative '../app/states/delivered_state'
require_relative '../app/states/invalid_state'

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
    it { is_expected.to respond_to(:assigned_to) }
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
      expect(order.state).to eq(RecievedState.new)
    end

    it 'allows in_preparation state' do
      order.state = StatesHelper.create_for('en_preparacion')

      expect(order.state).to eq(InPreparationState.new)
      expect(order.valid?).to eq(true)
    end

    it 'allows delivery state' do
      order.state = StatesHelper.create_for('en_entrega')

      expect(order.state).to eq(OnDeliveryState.new)
      expect(order.valid?).to eq(true)
    end

    it 'allows delivered state' do
      order.state = StatesHelper.create_for('entregado')

      expect(order.state).to eq(DeliveredState.new)
      expect(order.valid?).to eq(true)
    end

    it 'is invalid when changing to an invalid state' do
      order.state = StatesHelper.create_for('not_contemplated_state')

      expect(order.state).to eq(InvalidState.new)
      expect(order.valid?).to eq(false)
    end
  end

  describe 'rating' do
    it 'is valid when no rating' do
      expect(order.rating).to be_nil
      expect(order.valid?).to eq(true)
    end

    it 'is valid when rating with 3' do
      order.state =  StatesHelper.create_for('entregado')

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
      order.state = StatesHelper.create_for('en_preparacion')

      order.rating = 3

      expect(order.rating).to eq(3)
      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('order_not_delivered')
    end

    it 'is invalid when rating an order in delivering state' do
      order.state =  StatesHelper.create_for('en_entrega')

      order.rating = 3

      expect(order.rating).to eq(3)
      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('order_not_delivered')
    end

    it 'is invalid to rate an order with a value 1' do
      order.state =  StatesHelper.create_for('entregado')

      order.rating = -1

      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('invalid_rating')
    end

    it 'is invalid to rate an order with a value 6' do
      order.state =  StatesHelper.create_for('entregado')

      order.rating = 6

      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('invalid_rating')
    end
  end

  describe 'delivery assigment' do
    it 'should assign when status is in "en_entrega"' do
      delivery = Delivery.new('username' => 'pepemoto')
      DeliveryRepository.new.save(delivery)
      order.state = StatesHelper.create_for('en_entrega')
      expect(order.assigned_to).to eq(delivery.username)
    end
  end
end
