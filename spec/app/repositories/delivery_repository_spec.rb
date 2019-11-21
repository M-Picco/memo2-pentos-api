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

  describe 'exists' do
    it 'returns true for an existing delivery' do
      delivery = Delivery.new('username' => 'pepemoto')
      repository.save(delivery)

      exists = repository.exists?('pepemoto')

      expect(exists).to eq(true)
    end

    it 'returns false for an inexesisting delivery' do
      exists = repository.exists?('juanbicicleta')

      expect(exists).to eq(false)
    end

    it 'returns false for an inexesisting delivery with deliveries registered' do
      delivery = Delivery.new('username' => 'pepemoto')
      repository.save(delivery)
      exists = repository.exists?('juanbicicleta')

      expect(exists).to eq(false)
    end
  end
end
