require 'spec_helper'
require 'byebug'

describe LimitWaitingTimeFilter do
  let(:filter) { described_class.new }
  let(:delivery) do
    Delivery.new(username: 'pepemoto',
                 waiting_time: 5)
  end
  let(:delivery2) do
    Delivery.new(username: 'pepemoto',
                 waiting_time: 10)
  end
  let(:client) do
    client = Client.new(username: 'jperez', phone: '4123-4123',
                        address: 'Av Paseo Colón 840')
    ClientRepository.new.save(client)
    client
  end
  let(:order) do
    Order.new(client: client, type: 'menu_pareja')
  end

  it 'should filter deliveries with waiting time less than 10 minutes' do
    selected_deliveries = filter.apply([delivery, delivery2], order)
    expect(selected_deliveries.size).to eq 1
    expect(selected_deliveries[0]).to eq(delivery)
  end
end
