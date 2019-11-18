require_relative '../repositories/delivery_repository'
require_relative '../repositories/order_repository'
require_relative '../repositories/delivery_repository.rb'
require_relative '../repositories/order_repository'
require 'date'

class DeliveryAssigner
  def assign_to(order)
    order.assigned_to = delivery_with_fewer_orders
    OrderRepository.new.save(order)
  rescue NoMethodError
    order.assigned_to = nil
  end

  def delivery_with_fewer_orders
    # [ [delivery_username, q_delivered_orders] ]
    orders_delivered.min_by(&:last)[0]
  end

  def orders_delivered
    today_orders = OrderRepository.new.delivered_orders_created_on(Date.today)
    deliveries = DeliveryRepository.new.deliveries
    deliveries = Hash[deliveries.map { |delivery| [delivery, 0] }]
    # increase deliveries count
    today_orders.each do |order|
      deliveries[order.assigned_to] += 1
    end
    deliveries
  end

  def deliveries_fits(order)
    deliveries = DeliveryRepository.new.deliveries
    repository = OrderRepository.new
    elegible = []
    # [ ['delivery_name', bag_size] ]
    deliveries.each do |delivery|
      delivery_orders = repository.on_delivery_orders_by(delivery)
      bag = DeliveryBag.new
      bag.load_orders_from_collection(delivery_orders)
      elegible.append([delivery, bag.size]) if bag.fits?(order)
    end
    elegible
  end

  def nearest_full_deliveries_fits(order)
    # [ ['delivery_name', bag_size] ]
    deliveries = deliveries_fits(order)
    nearest = deliveries.min_by do |delivery|
      # delivery bag size
      delivery[1]
    end
    elegibles = deliveries.select { |element| element[1] == nearest[1] }
    # return only delivery names
    elegibles.map { |element| element[0] }
  end
end
