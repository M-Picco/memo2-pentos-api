require_relative './domain_error'

class InvalidParameterError < DomainError
  def initialize(msg)
    super
  end
end
