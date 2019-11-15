class ClientHasNoOrdersError < StandardError
  def initialize(msg = 'there are no orders')
    super
  end
end
