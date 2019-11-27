require_relative 'base_repository'
require_relative '../model/null_commission'
require_relative '../errors/order_not_found_error'
require_relative '../errors/client_has_no_orders_error'
require_relative '../states/state_factory'
require_relative '../states/delivered_state'
require_relative '../states/ondelivery_state'

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

  def orders_created_on(date)
    load_collection dataset.where(created_on: date..(date + 1))
  end

  def delivered_orders_created_on(date)
    load_collection dataset.where(created_on: date..(date + 1), state: STATES::DELIVERED)
  end

  def delivered_count_for(username, date)
    dataset.where(created_on: date..(date + 1),
                  state: DeliveredState.new.state_name,
                  assigned_to: username).count
  end

  def on_delivery_orders_by(username)
    load_collection dataset.where(assigned_to: username, state: STATES::ON_DELIVERY)
  end

  def historical_orders(client_username)
    load_collection dataset.where(client_username: client_username, state: STATES::DELIVERED)
  end

  def last_delivered_orders(menu_type, number)
    load_collection dataset
      .where(type: menu_type, state: STATES::DELIVERED)
      .order(Sequel.desc(:delivered_on))
      .limit(number)
  end

  protected

  def load_object(a_record)
    order = Order.new(a_record)

    order.client = ClientRepository.new.find_by_name(a_record[:client_username])

    order.commission = CommissionRepository.new.find_by_id(a_record[:commission])

    weather = order.commission.weather
    order.state = StateFactory.new(weather).create_for(a_record[:state])

    order
  end

  def changeset(order)
    {
      client_username: order.client.name,
      state: order.state.state_name,
      rating: order.rating,
      type: order.type,
      assigned_to: order.assigned_to,
      commission: order.commission&.id,
      delivered_on: order.delivered_on,
      on_delivery_time: order.on_delivery_time
    }
  end
end
