class OrderHelper
  def parse(order)
    return {} if order.nil?

    { id: order.id, menu: order.type.type_name, assigned_to: order.assigned_to,
      date: order.created_on.to_date.to_s }
  end
end
