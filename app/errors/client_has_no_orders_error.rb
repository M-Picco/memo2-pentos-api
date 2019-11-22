require_relative './domain_error'

class ClientHasNoOrdersError < DomainError
  def initialize(msg = 'there are no orders')
    super
  end
end
