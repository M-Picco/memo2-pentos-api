require_relative './domain_error'

class AlreadyRegisteredError < DomainError
  def initialize(msg = 'already_registered')
    super
  end
end
