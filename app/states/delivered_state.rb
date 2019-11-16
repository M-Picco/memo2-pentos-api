require_relative 'state'

class DeliveredState < State
  def initialize
    @state_name = 'entregado'
  end
end
