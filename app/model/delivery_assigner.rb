require_relative '../repositories/delivery_repository'
require_relative '../repositories/order_repository'

class DeliveryAssigner
  def delivery
    DeliveryRepository.new.first
  end

  def assign_to(order)
    order.assigned_to = delivery.username
    OrderRepository.new.save(order)
  rescue NoMethodError
    order.assigned_to = nil
  end
end
