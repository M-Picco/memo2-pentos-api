require 'integration_spec_helper'
require_relative '../../../app/errors/errors'

describe OrderRepository do
  let(:repository) { described_class.new }

  let(:client) do
    client = Client.new('username' => 'jperez', 'phone' => '4123-4123',
                        'address' => 'Av Paseo Colón 840')
    ClientRepository.new.save(client)
    client
  end

  it 'New Order' do
    order = Order.new(client: client)
    repository.save(order)
    expect(order.id).to be > 0
  end

  describe 'change state' do
    it 'changes the order state from received to in_preparation' do
      order = Order.new(client: client)
      repository.save(order)

      repository.change_order_state(order.id, 'en_preparacion')

      reloaded_order = repository.find(order.id)

      expect(reloaded_order.state).to eq('en_preparacion')
    end

    it 'fails to change the order state from received to
        an invalid state (any other than in_preparation)' do
      order = Order.new(client: client)
      repository.save(order)

      result = repository.change_order_state(order.id, 'un_estado_invalido')

      expect(result).to be(false)
    end
  end

  describe 'request order' do
    it 'given a client with orders, it should be true if
        I ask that the client has orders' do
      order = Order.new(client: client)
      repository.save(order)
      expect(repository.has_orders?(client.name)).to be(true)
    end

    it 'given a client without orders, it should be false if
        I ask that the client has orders' do
      expect(repository.has_orders?(client.name)).to be(false)
    end

    it 'should be able to find client order id' do
      order = Order.new(client: client)
      repository.save(order)
      reloaded_order = repository.find_for_user(order.id, client.name)
      expect(reloaded_order.id).to be(order.id)
    end

    it 'should not be able to find another client order id' do
      order = Order.new(client: client)
      repository.save(order)
      expect { repository.find_for_user(order.id, 'antoher_client') }
        .to raise_error(OrderNotFoundError)
    end
  end
end
