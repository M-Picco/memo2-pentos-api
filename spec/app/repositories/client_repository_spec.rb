require 'integration_spec_helper'

describe ClientRepository do
  let(:repository) { described_class.new }

  it 'create new client' do
    client = Client.new('username' => 'jperez',
                        'phone' => '4444-4564', 'address' => 'Av 1234')
    repository.save(client)
    expect(client.id).to be > 0
  end
end
