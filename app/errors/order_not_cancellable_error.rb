require_relative './domain_error'

class OrderNotCancellableError < DomainError
  def initialize(msg = 'cannot_cancel')
    super
  end
end
