class InPreparationState
  attr_reader :state_name

  def initialize
    @state_name = 'en_preparacion'
  end

  def name?(other_state)
    other_state == @state_name
  end

  def ==(other)
    other.name?(state_name)
  end
end
