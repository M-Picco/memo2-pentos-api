class AlreadyRegisteredError < StandardError
  def initialize(msg = 'already_registered')
    super
  end
end
