require_relative './domain_error'

class AlreadyRegisteredError < DomainError
  def initialize(msg = ERRORS::ALREADY_REGISTERED)
    super
  end
end
