require_relative 'state'

class CancelledState < State
  def initialize
    @state_name = STATES::CANCELLED
  end
end
