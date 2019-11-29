require_relative '../states/recieved_state'
require_relative '../states/inpreparation_state'
require_relative '../states/ondelivery_state'
require_relative '../states/delivered_state'
require_relative '../states/waiting_state'
require_relative '../errors/invalid_parameter_error'

class StateFactory
  STATE_CREATOR = { 'recibido' => proc { |_weather| RecievedState.new },
                    'en_preparacion' => proc { |_weather| InPreparationState.new },
                    'en_entrega' => proc { |weather| OnDeliveryState.new(weather) },
                    'entregado' => proc { |_weather| DeliveredState.new },
                    'cancelado' => proc { |_weather| CancelledState.new },
                    'en_espera' => proc { |_weather| WaitingState.new } }.freeze

  def initialize(weather)
    @weather = weather
  end

  def create_for(state_name)
    raise InvalidParameterError, 'invalid_state' unless STATE_CREATOR.include?(state_name)

    STATE_CREATOR[state_name].call(@weather)
  end
end
