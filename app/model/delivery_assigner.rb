require_relative '../repositories/delivery_repository'

class DeliveryAssigner
  def delivery
    DeliveryRepository.new.first
  end

  def assign_to(order)
    order.assigned_to = delivery.username
  rescue NoMethodError
    order.assigned_to = nil
  end
end
