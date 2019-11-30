require_relative './domain_error'

class NoDeliveryAvailableError < DomainError
  def initialize(msg = ERRORS::NO_DELIVERY_AVAILABLE)
    super
  end
end
