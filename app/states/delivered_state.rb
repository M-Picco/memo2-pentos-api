require_relative 'state'
require_relative '../repositories/commission_repository.rb'
require_relative '../model/commission.rb'
require_relative '../model/weather/non_rainy_weather.rb'

class DeliveredState < State
  def initialize(weather = nil)
    @state_name = STATES::DELIVERED
    @weather = weather
  end

  def on_enter(order)
    commission = Commission.new({ order_cost: order.cost }, @weather)
    CommissionRepository.new.save(commission)
    order.commission = commission
  end
end
