require_relative 'state'

class RecievedState < State
  def initialize
    @state_name = STATES::RECEIVED
  end
end
