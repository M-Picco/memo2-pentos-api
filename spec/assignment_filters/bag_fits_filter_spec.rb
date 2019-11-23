require 'spec_helper'

describe BagFitsFilter do
  let(:filter) { described_class.new }
  let(:delivery) { Delivery.new('username' => 'pepemoto') }
  let(:delivery2) { Delivery.new('username' => 'pepeauto') }
  let(:order) do
    Order.new(client: client, type: 'menu_familiar',
              assigned_to: delivery.username)
  end
  let(:client) do
    Client.new('username' => 'jperez', 'phone' => '4123-4123',
               'address' => 'Av Paseo Colón 840')
  end
  # rubocop:disable RSpec/ExampleLength

  it 'should filters Deliveries that theirs bag fits the order' do
    DeliveryRepository.new.save(delivery)
    DeliveryRepository.new.save(delivery2)
    order.change_state(OnDeliveryState.new)
    ClientRepository.new.save(client)
    OrderRepository.new.save(order)

    # return array of Deliveries
    delivery_selected = filter.apply([delivery, delivery2], order)
    expect(delivery_selected.first.id).to eq delivery2.id
  end

  it 'should called NearestFullFilter class' do
    DeliveryRepository.new.save(delivery)
    DeliveryRepository.new.save(delivery2)
    order.change_state(OnDeliveryState.new)
    ClientRepository.new.save(client)
    OrderRepository.new.save(order)

    expect(filter.next_filter).to receive(:run).with([delivery2], order)
    filter.run([delivery, delivery2], order)
  end
  # rubocop:enable RSpec/ExampleLength
end
