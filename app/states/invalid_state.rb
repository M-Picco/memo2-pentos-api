require_relative 'state'
require_relative 'state_names'

class InvalidState < State
  def initialize
    @state_name = STATES::INVALID
  end
end
