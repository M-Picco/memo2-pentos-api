require 'spec_helper'
require_relative '../app/model/delivery_assigner'

describe DeliveryAssigner do
  let(:sorting_hat) { described_class.new }
  let(:repository) { DeliveryRepository.new }

  it 'should return a delivery I save' do
    delivery = Delivery.new('username' => 'pepemoto')
    repository.save(delivery)
    sorted_delivery = sorting_hat.delivery

    expect(sorted_delivery.id).to eq(delivery.id)
  end
end
