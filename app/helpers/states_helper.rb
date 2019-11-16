require_relative '../states/recieved_state'
require_relative '../states/inpreparation_state'
require_relative '../states/ondelivery_state'

class StatesHelper
  STATE_CREATOR = { 'recibido' => RecievedState.new,
                    'en_preparacion' => InPreparationState.new,
                    'en_entrega' => OnDeliveryState.new }.freeze

  def self.create_for(state_name)
    STATE_CREATOR[state_name]
  end
end
