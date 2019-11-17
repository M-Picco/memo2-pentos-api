require 'active_model'

class Commission
  include ActiveModel::Validations

  attr_accessor :id, :amount, :order_cost, :updated_on, :created_on

  validates :order_cost, numericality: { greater_than_or_equal_to: 0 }

  def initialize(data = { order_cost: 0 })
    @id = data[:id]
    @order_cost = data[:order_cost]
    @amount = data[:amount] || 0.05 * @order_cost
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end

  def update_by_rating(rating)
    @amount = 0.03 * @order_cost if rating == 1
  end
end
