class ClientNotFoundError < StandardError
  def initialize(msg = 'not_registered')
    super
  end
end
