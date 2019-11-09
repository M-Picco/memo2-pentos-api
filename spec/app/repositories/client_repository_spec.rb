require 'spec_helper'
require_relative '../../../app/repositories/client_repository'

describe ClientRepository do
  let(:repository) { described_class.new }

  it 'create new client' do
    client = Client.new
    repository.save(client)
    client
  end
end
