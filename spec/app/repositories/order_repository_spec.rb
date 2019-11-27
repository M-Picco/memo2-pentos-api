require 'integration_spec_helper'
require_relative '../../../app/errors/order_not_found_error'
require_relative '../../../app/states/state_factory'
require_relative '../../../app/states/recieved_state'
require_relative '../../../app/states/inpreparation_state'
require_relative '../../../app/states/ondelivery_state'
require_relative '../../../app/states/delivered_state'
require_relative '../../../app/states/invalid_state'
require 'date'
require 'json'

describe OrderRepository do
  let(:repository) { described_class.new }

  let(:weather) { NonRainyWeather.new }

  let(:client) do
    client = Client.new('username' => 'jperez', 'phone' => '4123-4123',
                        'address' => 'Av Paseo Colón 840')
    ClientRepository.new.save(client)
    client
  end

  let(:client_two) do
    client = Client.new('username' => 'flopez', 'phone' => '4123-4123',
                        'address' => 'Av Paseo Colón 840')
    ClientRepository.new.save(client)
    client
  end

  it 'New Order' do
    order = Order.new(client: client, type: 'menu_individual')
    repository.save(order)
    expect(order.id).to be > 0
  end

  describe 'find by id' do
    it 'finds an order by its id' do
      order = Order.new(client: client, type: 'menu_individual')
      repository.save(order)

      reloaded_order = repository.find_by_id(order.id)

      expect(reloaded_order.id).to eq(order.id)
      expect(reloaded_order.client.name).to eq(order.client.name)
    end

    it 'fails to find an inexistent order' do
      expect { repository.find_by_id(999_999) }
        .to raise_error(OrderNotFoundError)
    end
  end

  describe 'find by username' do
    it 'finds an order for an existing username' do
      order = Order.new(client: client, type: 'menu_individual')
      repository.save(order)

      reloaded_order = repository.find_for_user(order.id, client.name)

      expect(reloaded_order.id).to eq(order.id)
      expect(reloaded_order.client.name).to eq(client.name)
    end

    it 'raises OrderNotFoundError if the order does not exist' do
      order = Order.new(client: client, type: 'menu_individual')
      repository.save(order)

      expect { repository.find_for_user(order.id + 1, client.name) }
        .to raise_error(OrderNotFoundError)
    end
  end

  describe 'request order' do
    it 'given a client with orders, it should be true if
        I ask that the client has orders' do
      order = Order.new(client: client, type: 'menu_individual')
      repository.save(order)
      expect(repository.has_orders?(client.name)).to be(true)
    end

    it 'given a client without orders, it should be false if
        I ask that the client has orders' do
      expect(repository.has_orders?(client.name)).to be(false)
    end

    it 'should be able to find client order id' do
      order = Order.new(client: client, type: 'menu_individual')
      repository.save(order)
      reloaded_order = repository.find_for_user(order.id, client.name)
      expect(reloaded_order.id).to be(order.id)
    end

    it 'should not be able to find another client order id' do
      order = Order.new(client: client, type: 'menu_individual')
      repository.save(order)
      expect { repository.find_for_user(order.id, 'antoher_client') }
        .to raise_error(OrderNotFoundError)
    end
  end

  # rubocop:disable RSpec/ExampleLength
  describe 'change rating' do
    it 'changes the rating of an order in delivered state' do
      order = Order.new(client: client, type: 'menu_individual')
      order.state = DeliveredState.new
      repository.save(order)

      order.rating = 3
      repository.save(order)

      reloaded_order = repository.find(order.id)

      expect(reloaded_order.rating).to eq(3)
    end

    it 'does not change the rating of an order with invalid rating
        due to not being in delivered state' do
      order = Order.new(client: client, type: 'menu_individual')
      repository.save(order)

      order.rating = 3
      repository.save(order)

      reloaded_order = repository.find(order.id)

      expect(reloaded_order.rating).to be_nil
    end

    it 'does not change the rating of an order with invalid rating
        due to it being above 5' do
      order = Order.new(client: client, type: 'menu_individual')
      order.state = DeliveredState.new
      repository.save(order)

      order.rating = 6
      repository.save(order)

      reloaded_order = repository.find(order.id)

      expect(reloaded_order.rating).to be_nil
    end

    it 'does not change the rating of an order with invalid rating
        due to it being below 1' do
      order = Order.new(client: client, type: 'menu_individual')
      order.state = DeliveredState.new
      repository.save(order)

      order.rating = 0
      repository.save(order)

      reloaded_order = repository.find(order.id)

      expect(reloaded_order.rating).to be_nil
    end
  end

  describe 'delivery assignment' do
    it 'should persist the assignment' do
      order = Order.new(client: client, type: 'menu_individual')
      repository.save(order)

      delivery = Delivery.new('username' => 'pepemoto')
      DeliveryRepository.new.save(delivery)

      order.change_state(StateFactory.new(weather).create_for('en_entrega'))

      repository.save(order)

      expect(repository.find(order.id).assigned_to).to eq(delivery.username)
    end
  end
  # rubocop:enable RSpec/ExampleLength

  describe 'today orders' do
    it 'should return an order made today' do
      order = Order.new(client: client, type: 'menu_individual')
      repository.save(order)

      orders = repository.orders_created_on(Date.today)

      expect(orders[0].id).to eq(order.id)
    end

    it 'should not return an order if i asked for yesterday orders' do
      order = Order.new(client: client, type: 'menu_individual')
      repository.save(order)

      orders = repository.orders_created_on(Date.today - 1)

      expect(orders.empty?).to eq(true)
    end

    it 'should not return a non delivered order made today' do
      order = Order.new(client: client, type: 'menu_individual')
      repository.save(order)

      orders = repository.delivered_orders_created_on(Date.today)

      expect(orders.empty?).to eq(true)
    end

    it 'should return a delivered order made today' do
      order = Order.new(client: client, type: 'menu_individual')
      order.state = DeliveredState.new
      repository.save(order)

      orders = repository.delivered_orders_created_on(Date.today)

      expect(orders[0].id).to eq(order.id)
    end
  end

  # rubocop:disable RSpec/ExampleLength
  describe 'historical orders' do
    it 'should return nothing if there are not orders' do
      orders = repository.historical_orders(client.name)
      expect(orders.size).to eq 0
    end

    it 'should return orders if there are orders' do
      order = Order.new(client: client, type: 'menu_individual')
      order.state = DeliveredState.new
      repository.save(order)

      orders = repository.historical_orders(client.name)
      expect(orders.size).to eq 1
      expect(orders[0].id).to eq order.id
    end

    it 'should not return orders if the client does not have orders' do
      order = Order.new(client: client, type: 'menu_individual')
      order.state = DeliveredState.new
      repository.save(order)

      orders = repository.historical_orders('juanSalaz')
      expect(orders.size).to eq 0
    end

    it "should return only the client's orders" do
      order = Order.new(client: client, type: 'menu_individual')
      order.state = DeliveredState.new
      repository.save(order)

      order_two = Order.new(client: client_two, type: 'menu_familiar')
      order_two.state = DeliveredState.new
      repository.save(order_two)

      orders = repository.historical_orders(client_two.name)

      expect(orders.size).to eq 1
      expect(orders[0].id).to eq order_two.id
    end

    it 'should not return recieved order' do
      order = Order.new(client: client, type: 'menu_familiar')
      repository.save(order)

      orders = repository.historical_orders(client.name)

      expect(orders.size).to eq 0
    end

    it 'should not return in preparation order' do
      order = Order.new(client: client, type: 'menu_familiar')
      order.state = InPreparationState.new
      repository.save(order)

      orders = repository.historical_orders(client.name)

      expect(orders.size).to eq 0
    end

    it 'should not return on delivery order' do
      order = Order.new(client: client, type: 'menu_familiar')
      order.state = OnDeliveryState.new(weather)
      repository.save(order)

      orders = repository.historical_orders(client.name)

      expect(orders.size).to eq 0
    end
  end

  describe 'delivery bag' do
    let(:order) do
      Order.new(client: client, type: 'menu_individual',
                assigned_to: delivery.username)
    end

    let(:delivery) { Delivery.new('username' => 'pepemoto') }

    it 'should return "en_entrega" orders assigned to delivery' do
      ClientRepository.new.save(client)
      DeliveryRepository.new.save(delivery)
      repository.save(order)

      order.change_state(StateFactory.new(weather).create_for('en_entrega'))
      on_delivery_orders = repository.on_delivery_orders_by(delivery.username)

      expect(on_delivery_orders[0].id).to eq(order.id)
    end
  end

  describe 'change commission' do
    it 'changes the commission of an order in delivered state' do
      order = Order.new(client: client, type: 'menu_individual')
      order.change_state(OnDeliveryState.new(weather))
      repository.save(order)

      reloaded_order = repository.find(order.id)

      expect(reloaded_order.commission.id).to be > 0
    end
  end

  describe 'last orders' do
    it 'returns one delivered order of the same type' do
      order = Order.new(client: client, type: 'menu_individual')
      order.change_state(DeliveredState.new)
      order2 = Order.new(client: client, type: 'menu_individual')
      order2.change_state(DeliveredState.new)
      repository.save(order)
      repository.save(order2)

      result = repository.last_delivered_orders('menu_individual', 1)
      expect(result.size).to eq(1)
    end

    it 'returns two delivered order of the same type' do
      order = Order.new(client: client, type: 'menu_individual')
      order.change_state(DeliveredState.new)
      order2 = Order.new(client: client, type: 'menu_individual')
      order2.change_state(DeliveredState.new)
      repository.save(order)
      repository.save(order2)

      result = repository.last_delivered_orders('menu_individual', 2)
      expect(result.size).to eq(2)
    end

    it 'returns the last delivered order of the same type' do
      order = Order.new(client: client, type: 'menu_individual')
      order.change_state(DeliveredState.new)
      order2 = Order.new(client: client, type: 'menu_individual')
      order2.change_state(DeliveredState.new)
      repository.save(order)
      repository.save(order2)

      result = repository.last_delivered_orders('menu_individual', 1)
      expect(result[0].id).to eq(order2.id)
    end
  end

  describe 'on_delivery time' do
    it 'should persist on_delivery time' do
      order = Order.new(client: client, type: 'menu_individual')
      date = Time.now.round
      order.on_delivery_time = date
      repository.save(order)
      reloaded_order = repository.find_by_id(order.id)
      expect(reloaded_order.on_delivery_time).to eq date
    end
  end
  # rubocop:enable RSpec/ExampleLength
end
