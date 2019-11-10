require_relative 'base_repository'
require_relative '../errors/errors'

class OrderRepository < BaseRepository
  self.table_name = :orders
  self.model_class = 'Order'

  def change_order_state(order_id, new_state)
    order = find order_id

    order.state = new_state

    save order
  end

  def has_orders?(user_name)
    !(load_collection dataset.where(client_username: user_name)).empty?
  end

  def find_for_user(order_id, user_name)
    order = find(order_id)
    raise OrderNotFoundError unless order.client.username?(user_name)

    order
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
