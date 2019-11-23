require 'spec_helper'

describe NearestToFullFilter do
  let(:filter) { described_class.new }
  let(:delivery) { Delivery.new('username' => 'pepemoto') }
  let(:delivery2) { Delivery.new('username' => 'pepeauto') }
  let(:order) do
    Order.new(client: client, type: 'menu_pareja',
              assigned_to: delivery.username)
  end
  let(:client) do
    Client.new('username' => 'jperez', 'phone' => '4123-4123',
               'address' => 'Av Paseo Colón 840')
  end
  # rubocop:disable RSpec/ExampleLength

  it 'should filters Deliveries that are nearest to full their bag' do
    DeliveryRepository.new.save(delivery)
    DeliveryRepository.new.save(delivery2)
    delivery.bag = DeliveryBag.new
    delivery2.bag = DeliveryBag.new

    delivery.bag.load_orders_from_collection([order])

    # return array of Deliveries
    delivery_selected = filter.apply([delivery, delivery2], order)
    expect(delivery_selected.first.id).to eq delivery.id
  end

  it 'should called DeliveredCount class' do
    DeliveryRepository.new.save(delivery)
    DeliveryRepository.new.save(delivery2)
    delivery.bag = DeliveryBag.new
    delivery2.bag = DeliveryBag.new

    delivery.bag.load_orders_from_collection([order])

    expect(filter.next_filter).to receive(:run).with([delivery], order)
    filter.run([delivery, delivery2], order)
  end
  # rubocop:enable RSpec/ExampleLength
end
