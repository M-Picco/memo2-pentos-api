require_relative 'state'
require_relative '../repositories/commission_repository.rb'
require_relative '../model/commission.rb'
require_relative '../model/weather/non_rainy_weather.rb'

class DeliveredState < State
  def initialize
    @state_name = STATES::DELIVERED
  end
end
