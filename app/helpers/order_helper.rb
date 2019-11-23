class OrderHelper
  def parse(order)
    return {} if order.nil?

    { id: order.id, menu: order.type }
  end
end
