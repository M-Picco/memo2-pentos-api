require_relative '../repositories/delivery_repository'

class DeliveryAssigner
  def delivery
    DeliveryRepository.new.first
  end
end
