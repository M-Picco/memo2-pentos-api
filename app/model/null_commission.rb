require_relative '../errors/order_not_delivered_error'

class NullCommission
  def amount
    raise OrderNotDeliveredError
  end
end
