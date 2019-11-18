class DeliveryBag
  attr_reader :size

  def initialize
    @size = 3
  end

  def load_order(order)
    @size -= order.size
  end

  def fits?(order)
    (@size - order.size) >= 0
  end
end
