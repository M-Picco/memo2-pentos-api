require_relative 'base_repository'
require_relative '../errors/order_not_found_error'
require_relative '../errors/client_has_no_orders_error'

class OrderRepository < BaseRepository
  self.table_name = :orders
  self.model_class = 'Order'

  def find_by_id(order_id)
    find(order_id)
  rescue Sequel::NoMatchingRow
    raise OrderNotFoundError
  end

  def has_orders?(user_name)
    !(load_collection dataset.where(client_username: user_name)).empty?
  end

  def find_for_user(order_id, user_name)
    order = find(order_id)
    raise OrderNotFoundError unless order.client.username?(user_name)

    order
  rescue Sequel::NoMatchingRow
    raise OrderNotFoundError
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
      state: order.state,
      rating: order.rating,
      type: order.type
    }
  end
end
