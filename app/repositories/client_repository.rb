require_relative 'base_repository'

class ClientRepository < BaseRepository
  self.table_name = :clients
  self.model_class = 'Client'

  protected

  def changeset(client)
    {
      name: client.name,
      phone: client.phone,
      address: client.address
    }
  end
end
