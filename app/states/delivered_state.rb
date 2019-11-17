require_relative 'state'
require_relative '../repositories/commission_repository.rb'
require_relative '../model/commission.rb'

class DeliveredState < State
  def initialize
    @state_name = 'entregado'
  end

  def on_enter(order)
    commission = Commission.new(order_cost: order.cost)
    CommissionRepository.new.save(commission)
    order.commission = commission
  end
end
