class OrderHelper
  def parse(order)
    return {} if order.nil?

    { id: order.id, menu: order.type, assigned_to: order.assigned_to, date: order.created_on.to_s }
  end
end
