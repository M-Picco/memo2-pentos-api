require_relative './domain_error'

class OrderNotDeliveredError < DomainError
  def initialize(msg = 'order_not_delivered')
    super
  end
end
