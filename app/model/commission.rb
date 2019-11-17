require 'active_model'

class Commission
  include ActiveModel::Validations

  attr_accessor :id, :amount, :order_cost, :updated_on, :created_on

  validates :order_cost, numericality: { greater_than_or_equal_to: 0 }

  def initialize(data = {})
    @id = data[:id]
    @order_cost = data[:order_cost]
    @amount = 0.05 * @order_cost
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end
end
