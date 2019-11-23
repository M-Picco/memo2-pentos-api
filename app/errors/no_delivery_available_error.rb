require_relative './domain_error'

class NoDeliveryAvailableError < DomainError
  def initialize(msg = 'there are no deliveries available')
    super
  end
end
