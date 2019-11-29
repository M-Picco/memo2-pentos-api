require 'spec_helper'

describe LessDeliveredFilter do
  let(:filter) { described_class.new }
  let(:delivery) do
    Delivery.new(username: 'pepemoto',
                 delivered_count: 1)
  end
  let(:delivery2) do
    Delivery.new(username: 'pepeauto',
                 delivered_count: 0)
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

  it 'should add delivered count to deliveries ' do
    DeliveryRepository.new.save(delivery)
    DeliveryRepository.new.save(delivery2)
    # return a Delivery
    selected_delivery = filter.apply([delivery, delivery2], order)
    expect(selected_delivery.id).to eq delivery2.id
  end

  it 'should end the chain' do
    DeliveryRepository.new.save(delivery)
    DeliveryRepository.new.save(delivery2)

    expect(filter.apply([delivery, delivery2], order))
      .to eq filter.run([delivery, delivery2], order)
  end
end
