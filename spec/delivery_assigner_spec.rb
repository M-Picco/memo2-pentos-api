require 'spec_helper'
require_relative '../app/model/delivery_assigner'
require_relative '../app/model/order'
require_relative '../app/model/client'

describe DeliveryAssigner do
  let(:sorting_hat) { described_class.new }
  let(:repository) { DeliveryRepository.new }

  let(:client) do
    Client.new('username' => 'jperez', 'phone' => '4123-4123',
               'address' => 'Av Paseo Colón 840')
  end

  let(:order) { Order.new(client: client, type: 'menu_individual') }

  it 'should return a delivery I save' do
    delivery = Delivery.new('username' => 'pepemoto')
    repository.save(delivery)
    sorted_delivery = sorting_hat.delivery

    expect(sorted_delivery.id).to eq(delivery.id)
  end

  it 'given an order, delivery assigner should assign it a delivery' do
    delivery = Delivery.new('username' => 'pepemoto')
    repository.save(delivery)
    sorting_hat.assign_to(order)
    expect(order.assigned_to).not_to eq(nil)
  end
end
