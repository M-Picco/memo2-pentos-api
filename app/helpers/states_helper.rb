require_relative '../states/recieved_state'

class StatesHelper
  def self.create_for(_string_state)
    RecievedState.new
  end
end
