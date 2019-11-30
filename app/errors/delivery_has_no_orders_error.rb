require_relative './domain_error'

class DeliveryHasNoOrdersError < DomainError
  def initialize(msg = ERRORS::CLIENT_HAS_NO_ORDERS)
    super
  end
end
