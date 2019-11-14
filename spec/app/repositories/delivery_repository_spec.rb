require 'integration_spec_helper'

describe DeliveryRepository do
  let(:repository) { described_class.new }

  it 'create new delivery' do
    delivery = Delivery.new('username' => 'pepemoto')
    repository.save(delivery)
    expect(delivery.id).to be > 0
  end
end
