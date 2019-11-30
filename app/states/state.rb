class State
  attr_reader :state_name

  def initialize
    raise ERRORS::SUBCLASS_RESPONSIBILITY
  end

  def on_enter(order); end

  def name?(other_state)
    other_state == @state_name
  end
end
