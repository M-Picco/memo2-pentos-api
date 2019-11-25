require_relative 'state'
require_relative '../repositories/commission_repository.rb'
require_relative '../model/commission.rb'
require_relative '../model/weather/non_rainy_weather.rb'
require 'date'

class DeliveredState < State
  def initialize
    @state_name = STATES::DELIVERED
  end

  def on_enter(order)
    order.delivered_on = Time.now
  end
end
