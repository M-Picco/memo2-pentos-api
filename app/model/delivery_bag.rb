class DeliveryBag
  attr_reader :size

  def initialize
    @size = 3
  end

  def load_order(_order)
    @size -= 1
  end
end
