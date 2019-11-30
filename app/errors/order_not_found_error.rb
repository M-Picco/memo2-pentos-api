require_relative './domain_error'

class OrderNotFoundError < DomainError
  def initialize(msg = ERRORS::ORDER_NOT_EXIST)
    super
  end
end
