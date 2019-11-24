require_relative './domain_error'

class OrderNotFoundError < DomainError
  def initialize(msg = 'order not exist')
    super
  end
end
