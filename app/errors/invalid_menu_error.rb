require_relative './domain_error'

class InvalidMenuError < DomainError
  def initialize(msg = 'invalid_menu')
    super
  end
end
