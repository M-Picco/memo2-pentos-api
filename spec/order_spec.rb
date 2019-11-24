require 'spec_helper'
require_relative '../app/states/state_factory'
require_relative '../app/states/recieved_state'
require_relative '../app/states/inpreparation_state'
require_relative '../app/states/ondelivery_state'
require_relative '../app/states/delivered_state'
require_relative '../app/states/invalid_state'

describe Order do
  subject(:order) { described_class.new(client: client, type: 'menu_individual') }

  let(:weather) { NonRainyWeather.new }

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
    it { is_expected.to respond_to(:commission) }
    it { is_expected.to respond_to(:delivered_on) }
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

  describe 'cost' do
    it 'should be 100 if is a menu_individual type' do
      order = described_class.new(client: client, type: 'menu_individual')
      expect(order.cost).to eq(100)
    end

    it 'should be 175 if is a menu_parejas type' do
      order = described_class.new(client: client, type: 'menu_pareja')
      expect(order.cost).to eq(175)
    end

    it 'should be 250 if is a menu_familiar type' do
      order = described_class.new(client: client, type: 'menu_familiar')
      expect(order.cost).to eq(250)
    end
  end

  describe 'state' do
    it 'has "received" as initial value' do
      expect(order.state).to be_a(RecievedState)
    end

    it 'allows in_preparation state' do
      order.state = StateFactory.new(weather).create_for('en_preparacion')

      expect(order.state).to be_a(InPreparationState)
      expect(order.valid?).to eq(true)
    end

    it 'allows delivery state' do
      order.state = StateFactory.new(weather).create_for('en_entrega')

      expect(order.state).to be_a(OnDeliveryState)
      expect(order.valid?).to eq(true)
    end

    it 'allows delivered state' do
      order.state = StateFactory.new(weather).create_for('entregado')

      expect(order.state).to be_a(DeliveredState)
      expect(order.valid?).to eq(true)
    end

    it 'is invalid when changing to an invalid state' do
      order.state = StateFactory.new(weather).create_for('not_contemplated_state')

      expect(order.state).to be_a(InvalidState)
      expect(order.valid?).to eq(false)
    end
  end

  describe 'rating' do
    it 'is valid when no rating' do
      expect(order.rating).to be_nil
      expect(order.valid?).to eq(true)
    end

    it 'is valid when rating with 3' do
      order.state =  StateFactory.new(weather).create_for('entregado')

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
      order.state = StateFactory.new(weather).create_for('en_preparacion')

      order.rating = 3

      expect(order.rating).to eq(3)
      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('order_not_delivered')
    end

    it 'is invalid when rating an order in delivering state' do
      order.state =  StateFactory.new(weather).create_for('en_entrega')

      order.rating = 3

      expect(order.rating).to eq(3)
      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('order_not_delivered')
    end

    it 'is invalid to rate an order with a value 1' do
      order.state =  StateFactory.new(weather).create_for('entregado')

      order.rating = -1

      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('invalid_rating')
    end

    it 'is invalid to rate an order with a value 6' do
      order.state =  StateFactory.new(weather).create_for('entregado')

      order.rating = 6

      expect(order.valid?).to eq(false)
      expect(order.errors.messages.first[1].first).to eq('invalid_rating')
    end
  end

  describe 'delivery assigment' do
    it 'should assign when status is in "en_entrega"' do
      delivery = Delivery.new('username' => 'pepemoto')
      DeliveryRepository.new.save(delivery)
      order.change_state(StateFactory.new(weather).create_for('en_entrega'))
      expect(order.assigned_to).to eq(delivery.username)
    end
  end

  describe 'commission' do
    it 'should create when status is in "entregado"' do
      order.change_state(StateFactory.new(weather).create_for('en_entrega'))
      expect(order.commission.nil?).to eq false
      expect(order.commission.id).to be > 0
    end
  end

  describe 'cancel' do
    it 'should be possible to cancel a received order' do
      order.cancel

      expect(order.state.name?(STATES::CANCELLED)).to eq(true)
    end

    it 'should be possible to cancel an order in preparation' do
      order.change_state(InPreparationState.new)

      order.cancel

      expect(order.state.name?(STATES::CANCELLED)).to eq(true)
    end

    it 'should fail to cancel an order on delivery' do
      order.change_state(OnDeliveryState.new(weather))

      expect { order.cancel }.to raise_error(OrderNotCancellableError)
    end

    it 'should fail to cancel a delivered order' do
      order.change_state(DeliveredState.new)

      expect { order.cancel }.to raise_error(OrderNotCancellableError)
    end

    it 'should fail to cancel a waiting order' do
      order.change_state(WaitingState.new)

      expect { order.cancel }.to raise_error(OrderNotCancellableError)
    end
  end

  describe 'base time' do
    it 'should be 10 minutes when order type is menu_individual' do
      order = described_class.new(client: client, type: 'menu_individual')
      expect(order.base_time).to eq(10)
    end

    it 'should be 15 minutes when order type is menu_pareja' do
      order = described_class.new(client: client, type: 'menu_pareja')
      expect(order.base_time).to eq(15)
    end

    it 'should be 20 minutes when order type is menu_individual' do
      order = described_class.new(client: client, type: 'menu_familiar')
      expect(order.base_time).to eq(20)
    end
  end

  describe 'delivered_time' do
    it 'should have created as Time ' do
      order = described_class.new(client: client, type: 'menu_individual')
      OrderRepository.new.save(order)
      ClientRepository.new.save(client)
      reloaded_order = OrderRepository.new.find_by_id(order.id)
      expect(reloaded_order.created_on).to be_a(Time)
    end
  end
end
