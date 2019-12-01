require 'spec_helper'

describe DeliveredCountFilter do
  let(:filter) { described_class.new }
  let(:delivery) { Delivery.new(username: 'pepemoto') }
  let(:delivery2) { Delivery.new(username: 'pepeauto') }
  let(:order) do
    type = OrderTypeFactory.new.create_for('menu_familiar')
    Order.new(client: client, type: type,
              assigned_to: delivery.username)
  end
  let(:client) do
    Client.new(username: 'jperez', phone: '4123-4123',
               address: 'Av Paseo Colón 840')
  end

  before(:each) do
    DeliveryRepository.new.save(delivery)
    DeliveryRepository.new.save(delivery2)
    order.change_state(DeliveredState.new)
    ClientRepository.new.save(client)
    OrderRepository.new.save(order)
  end

  it 'should add delivered count to deliveries ' do
    # return array of Deliveries
    deliveries = filter.apply([delivery, delivery2], order)
    expect(deliveries.first.delivered_count).to eq 1
    expect(deliveries[1].delivered_count).to eq 0
  end

  it 'should called LessDelivered class' do
    expect(filter.next_filter).to receive(:run).with([delivery, delivery2], order)
    filter.run([delivery, delivery2], order)
  end
end
