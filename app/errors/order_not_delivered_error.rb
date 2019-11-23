class OrderNotDeliveredError < StandardError
  def initialize(msg = 'order_not_delivered')
    super
  end
end
