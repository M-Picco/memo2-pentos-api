require_relative '../states/recibido_state'

class StatesHelper
  def self.create_for(_string_state)
    RecibidoState.new
  end
end
