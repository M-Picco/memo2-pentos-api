require 'integration_spec_helper'

describe ClientRepository do
  let(:repository) { described_class.new }

  it 'create new client' do
    client = Client.new('username' => 'jperez',
                        'phone' => '4444-4564', 'address' => 'Av 1234')
    repository.save(client)
    expect(client.id).to be > 0
  end

  describe 'find_by_name' do
    # rubocop:disable RSpec/ExampleLength:
    it 'finds a user by name' do
      client = Client.new('username' => 'jperez',
                          'phone' => '4444-4564', 'address' => 'Av 1234')

      repository.save(client)

      reloaded_client = repository.find_by_name('jperez')

      expect(reloaded_client.id).to eq(client.id)
      expect(reloaded_client.name).to eq('jperez')
    end
    # rubocop:enable RSpec/ExampleLength:
  end
end
