class OrderHelper
  def parse(order)
    return {} if order.nil?

    { id: order.id }
  end
end
