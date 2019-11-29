require 'spec_helper'
require_relative '../app/states/state_factory'
require_relative '../app/states/recieved_state'
require_relative '../app/states/inpreparation_state'
require_relative '../app/states/ondelivery_state'
require_relative '../app/states/delivered_state'

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
    it { is_expected.to respond_to(:on_delivery_time) }
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
    end

    it 'allows delivery state' do
      order.state = StateFactory.new(weather).create_for('en_entrega')

      expect(order.state).to be_a(OnDeliveryState)
    end

    it 'allows delivered state' do
      order.state = StateFactory.new(weather).create_for('entregado')

      expect(order.state).to be_a(DeliveredState)
    end
  end

  describe 'rating' do
    it 'is valid when rating with 3' do
      order.state =  StateFactory.new(weather).create_for('entregado')

      order.rating = 3

      expect(order.rating).to eq(3)
    end

    it 'raises InvalidOperationError when rating an order in received state' do
      expect { order.rating = 3 }.to raise_error('order_not_delivered')
    end

    it 'raises InvalidOperationError when rating an order in in_preparation state' do
      order.state = StateFactory.new(weather).create_for('en_preparacion')

      expect { order.rating = 3 }.to raise_error('order_not_delivered')
    end

    it 'raises InvalidOperationError when rating an order in delivering state' do
      order.state = StateFactory.new(weather).create_for('en_entrega')

      expect { order.rating = 3 }.to raise_error('order_not_delivered')
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
      OrderRepository.new.save(order)
      ClientRepository.new.save(client)
      reloaded_order = OrderRepository.new.find_by_id(order.id)
      expect(reloaded_order.created_on).to be_a(Time)
    end

    it 'should have delivered_on as Time ' do
      order.delivered_on = Time.now
      OrderRepository.new.save(order)
      ClientRepository.new.save(client)
      reloaded_order = OrderRepository.new.find_by_id(order.id)
      expect(reloaded_order.delivered_on).to be_a(Time)
    end

    it 'should be deliverd_time - created_time' do
      OrderRepository.new.save(order)
      ClientRepository.new.save(client)
      reloaded_order = OrderRepository.new.find_by_id(order.id)
      reloaded_order.delivered_on = reloaded_order.created_on + (60 * 5)
      expect(reloaded_order.duration).to eq(5)
    end
  end

  describe 'delivered time' do
    it 'delivered state should set delivered time' do
      order.change_state(DeliveredState.new)
      expect(order.delivered_on).not_to eq(nil)
    end

    it 'should set on_delivery_time when OnDeliveryStatus is set' do
      order.change_state(OnDeliveryState.new(weather))
      expect(order.on_delivery_time).not_to eq(nil)
    end
  end
end
