require 'integration_spec_helper'

describe DeliveryRepository do
  let(:repository) { described_class.new }

  it 'create new delivery' do
    delivery = Delivery.new('username' => 'pepemoto')
    repository.save(delivery)
    expect(delivery.id).to be > 0
  end
  # rubocop:disable RSpect/ExampleLength

  it 'should return a list with delivery usernames' do
    delivery = Delivery.new('username' => 'pepemoto')
    delivery2 = Delivery.new('username' => 'pepemonopatin')
    repository.save(delivery)
    repository.save(delivery2)

    expect(repository.deliveries.include?(delivery.username)).to eq true
    expect(repository.deliveries.include?(delivery2.username)).to eq true
  end
  # rubocop:enable RSpect/ExampleLength
end
