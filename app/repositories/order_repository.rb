require_relative 'base_repository'

class OrderRepository < BaseRepository
  self.table_name = :orders
  self.model_class = 'Order'

  def change_order_state(order_id, new_state)
    order = find order_id

    order.state = new_state

    save order
  end

  def has_orders?(_user_name)
    true
  end

  protected

  def load_object(a_record)
    order = Order.new(a_record)

    order.client = ClientRepository.new.find_by_name(a_record[:client_username])

    order
  end

  def changeset(order)
    {
      client_username: order.client.name,
      state: order.state
    }
  end
end
