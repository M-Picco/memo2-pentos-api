require_relative 'state'

class OnDeliveryState < State
  def initialize
    @state_name = 'en_entrega'
  end
end
