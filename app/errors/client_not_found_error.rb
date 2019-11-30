require_relative './domain_error'

class ClientNotFoundError < DomainError
  def initialize(msg = ERRORS::NOT_REGISTERED)
    super
  end
end
