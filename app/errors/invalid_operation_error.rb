require_relative './domain_error'

class InvalidOperationError < DomainError
  def initialize(msg)
    super
  end
end
