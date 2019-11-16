require_relative 'base_repository'
require_relative '../errors/client_not_found_error'

class ClientRepository < BaseRepository
  self.table_name = :clients
  self.model_class = 'Client'

  def find_by_name(client_name)
    row = dataset.first(username: client_name)

    raise ClientNotFoundError if row.nil?

    load_object(row)
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
