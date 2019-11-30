require_relative './domain_error'

class ClientHasNoOrdersError < DomainError
  def initialize(msg = ERRORS::CLIENT_HAS_NO_ORDERS)
    super
  end
end
