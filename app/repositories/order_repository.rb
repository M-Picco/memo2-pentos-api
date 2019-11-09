require_relative 'base_repository'

class OrderRepository < BaseRepository
  self.table_name = :orders
  self.model_class = 'Order'

  protected

  def changeset(order)
    {
      client_username: order.client.name,
      state: order.state
    }
  end
end
