require 'spec_helper'
require_relative '../app/model/delivery_assigner'
require_relative '../app/repositories/order_repository.rb'
require_relative '../app/repositories/client_repository.rb'
require_relative '../app/model/order'
require_relative '../app/model/client'
require 'byebug'

describe DeliveryAssigner do
  let(:sorting_hat) { described_class.new }
  let(:repository) { DeliveryRepository.new }
  let(:orders_repository) { OrderRepository.new }
  let(:client_repository) { ClientRepository.new }

  let(:client) do
    Client.new('username' => 'jperez', 'phone' => '4123-4123',
               'address' => 'Av Paseo Colón 840')
  end

  let(:order) { Order.new(client: client, type: 'menu_individual') }

  it 'should return a delivery I save' do
    delivery = Delivery.new('username' => 'pepemoto')
    repository.save(delivery)
    sorted_delivery = sorting_hat.delivery_with_fewer_orders

    expect(sorted_delivery).to eq(delivery.username)
  end

  it 'given an order, delivery assigner should assign it a delivery' do
    delivery = Delivery.new('username' => 'pepemoto')
    repository.save(delivery)
    sorting_hat.assign_to(order)
    expect(order.assigned_to).not_to eq(nil)
  end
  # rubocop:disable RSpect/ExampleLength

  it 'should return a delivery with his orders deliverd today' do
    delivery = Delivery.new('username' => 'pepemoto')
    delivery2 = Delivery.new('username' => 'pepeauto')
    order = Order.new(client: client, type: 'menu_individual',
                      assigned_to: delivery.username)
    order.state = DeliveredState.new

    client_repository.save(client)
    repository.save(delivery)
    repository.save(delivery2)
    orders_repository.save(order)

    # { 'username' => q_orders_delivered}
    delivery_orders = sorting_hat.orders_delivered

    expect(delivery_orders[delivery.username]).to eq(1)
  end

  it 'should assign the delivery with less delivered orders' do
    delivery = Delivery.new('username' => 'pepemoto')
    delivery2 = Delivery.new('username' => 'pepeauto')
    order = Order.new(client: client, type: 'menu_individual',
                      assigned_to: delivery.username)
    order.state = DeliveredState.new

    client_repository.save(client)
    repository.save(delivery)
    repository.save(delivery2)
    orders_repository.save(order)

    sorting_hat.assign_to(order)
    expect(order.assigned_to).to eq(delivery2.username)
  end

  it 'should return deliveries that order fits in bag' do
    delivery = Delivery.new('username' => 'pepemoto')
    delivery2 = Delivery.new('username' => 'pepeauto')

    order = Order.new(client: client, type: 'menu_familiar',
                      assigned_to: delivery.username)

    repository.save(delivery)
    repository.save(delivery2)
    order.change_state(OnDeliveryState.new)

    client_repository.save(client)
    orders_repository.save(order)

    # [ ['delivery_name', bag_size] ]
    deliveries = sorting_hat.deliveries_fits(order)

    expect(deliveries[0][0]).not_to eq order.assigned_to
  end

  it 'should return nearest delivery to full the bag' do
    delivery = Delivery.new('username' => 'pepemoto')
    delivery2 = Delivery.new('username' => 'pepeauto')
    
    order = Order.new(client: client, type: 'menu_individual',
                      assigned_to: delivery.username)

    repository.save(delivery)
    repository.save(delivery2)
    order.change_state(OnDeliveryState.new)

    client_repository.save(client)
    orders_repository.save(order)

    # [ ['delivery_name', bag_size] ]
    deliveries = sorting_hat.nearest_full_deliveries_fits(order)

    expect(deliveries[0]).to eq(delivery.username)
  end

  it 'should return all the nearest deliveries to full the bag' do
    delivery = Delivery.new('username' => 'pepemoto')
    delivery2 = Delivery.new('username' => 'pepeauto')
    
    order = Order.new(client: client, type: 'menu_individual')

    repository.save(delivery)
    repository.save(delivery2)
 
    client_repository.save(client)
 
    # [ ['delivery_name', bag_size] ]
    deliveries = sorting_hat.nearest_full_deliveries_fits(order)

    expect(deliveries.size).to eq(2)
  end
  # rubocop:enable RSpect/ExampleLength
end
