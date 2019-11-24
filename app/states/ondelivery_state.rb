require_relative 'state'
require_relative '../model/delivery_assigner'

class OnDeliveryState < State
  def initialize(weather)
    @state_name = STATES::ON_DELIVERY
    @weather = weather
  end

  def on_enter(order)
    DeliveryAssigner.new.assign_to(order)

    commission = Commission.new({ order_cost: order.cost }, @weather)
    CommissionRepository.new.save(commission)
    order.commission = commission
  end
end
