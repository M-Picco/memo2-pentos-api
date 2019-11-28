require_relative './domain_error'

class DeliveryHasNoOrdersError < DomainError
  def initialize(msg = 'there are no orders')
    super
  end
end
