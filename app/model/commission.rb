class Commission
  attr_accessor :id, :amount, :order_cost

  def initialize(order_cost)
    @order_cost = order_cost
  end
end
