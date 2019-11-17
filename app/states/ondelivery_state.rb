require_relative 'state'
require_relative '../model/delivery_assigner'

class OnDeliveryState < State
  def initialize
    @state_name = 'en_entrega'
  end

  def on_enter(order)
    DeliveryAssigner.new.assign_to(order)
  end
end