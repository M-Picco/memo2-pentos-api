class OrderNotFoundError < StandardError
  def initialize(msg = 'order not exist')
    super
  end
end
