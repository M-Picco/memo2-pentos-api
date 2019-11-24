require_relative 'state'

class InPreparationState < State
  attr_reader :state_name

  def initialize
    @state_name = STATES::IN_PREPARATION
  end
end
