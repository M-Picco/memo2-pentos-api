require_relative './domain_error'

class OrderNotDeliveredError < DomainError
  def initialize(msg = ERRORS::ORDER_NOT_DELIVERED)
    super
  end
end
