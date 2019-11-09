require 'spec_helper'
require_relative '../../../app/repositories/order_repository'

describe OrderRepository do
  let(:repository) { described_class.new }

  let(:client) do
    Client.new('username' => 'jperez', 'phone' => '4123-4123',
               'address' => 'Av Paseo Colón 840')
  end

  it 'New Order' do
    order = Order.new('order' => 1, 'client' => client)
    repository.save(order)
    order
  end
end
