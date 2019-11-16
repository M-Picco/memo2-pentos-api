require_relative 'state'

class RecievedState < State
  def initialize
    @state_name = 'recibido'
  end
end
