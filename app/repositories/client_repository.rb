require_relative 'base_repository'

class ClientRepository < BaseRepository
  self.table_name = :clients
  self.model_class = 'Client'

  def find_by_name(client_name)
    row = dataset.first(username: client_name)
    load_object(row) unless row.nil?
  end

  protected

  def changeset(client)
    {
      username: client.name,
      phone: client.phone,
      address: client.address
    }
  end
end
