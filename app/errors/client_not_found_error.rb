class ClientNotFoundError < StandardError
  def initialize(msg = 'client_not_exist')
    super
  end
end
