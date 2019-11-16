require_relative 'state'

class InvalidState < State
  def initialize
    @state_name = 'invalid_state'
  end
end
