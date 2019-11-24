require_relative './domain_error'

class ClientNotFoundError < DomainError
  def initialize(msg = 'not_registered')
    super
  end
end
