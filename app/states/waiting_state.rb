require_relative 'state'

class WaitingState < State
  def initialize
    @state_name = STATES::WAITING
  end
end
