require 'integration_spec_helper'

describe OrderRepository do
  let(:repository) { described_class.new }

  let(:client) do
    client = Client.new('username' => 'jperez', 'phone' => '4123-4123',
                        'address' => 'Av Paseo Colón 840')
    ClientRepository.new.save(client)
    client
  end

  it 'New Order' do
    order = Order.new('client' => client)
    repository.save(order)
    expect(order.id).to be > 0
  end
end
