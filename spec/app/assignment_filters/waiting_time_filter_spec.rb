require 'spec_helper'
require 'byebug'

describe WaitingTimeFilter do
  let(:filter) { described_class.new }
  let(:delivery) { Delivery.new(username: 'pepemoto') }

  let(:client) do
    Client.new(username: 'jperez', phone: '4123-4123',
               address: 'Av Paseo Colón 840')
  end
  let(:order) do
    Order.new(client: client, type: 'menu_pareja',
              assigned_to: delivery.username)
  end
  # rubocop:disable RSpec/ExampleLength

  it 'should add waiting time to delivery' do
    ClientRepository.new.save(client)
    minutes = 20
    date = Time.now.round - (minutes * 60)
    order.on_delivery_time = date
    order.state = OnDeliveryState.new(NonRainyWeather.new)
    OrderRepository.new.save(order)
    filter.apply([delivery], order)
    expect(delivery.waiting_time).to eq(20)
  end
  # rubocop:enable RSpec/ExampleLength

  it 'should assign 0 waiting time when delivery has no orders' do
    filter.apply([delivery], order)
    expect(delivery.waiting_time).to eq(0)
  end
end
