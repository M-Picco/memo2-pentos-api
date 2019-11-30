require_relative './domain_error'

class OrderNotCancellableError < DomainError
  def initialize(msg = ERRORS::NOT_CANCELLABLE)
    super
  end
end
