require_relative 'base_repository'

class OrderRepository < BaseRepository
  self.table_name = :orders
  self.model_class = 'Order'

  protected

  def changeset(order)
    {
      id: order.id,
      client: order.client.name
    }
  end
end
