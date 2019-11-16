class State
  attr_reader :state_name

  def initialize
    raise 'Subclass must implement'
  end

  def on_enter(order); end

  def name?(other_state)
    other_state == @state_name
  end

  def ==(other)
    other.name?(state_name)
  end
end
