require 'active_model'

class Commission
  include ActiveModel::Validations

  attr_accessor :id, :amount, :order_cost, :updated_on, :created_on, :weather

  validates :order_cost, numericality: { greater_than_or_equal_to: 0 }

  BASE_PERCENTAGE = 0.05
  MIN_PERCENTAGE = 0.03
  MAX_PERCENTAGE = 0.07

  def initialize(data)
    @id = data[:id]
    @order_cost = data[:order_cost] || 0
    @amount = data[:amount] || BASE_PERCENTAGE * @order_cost
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end

  def update_by_rating(rating)
    @amount = MIN_PERCENTAGE * @order_cost if rating == 1
    @amount = MAX_PERCENTAGE * @order_cost if rating == 5
  end
end
