require 'active_model'

class Commission
  include ActiveModel::Validations

  attr_accessor :id, :amount, :order_cost

  validates :order_cost, numericality: { greater_than_or_equal_to: 0 }

  def initialize(data = { 'order_cost' => 0 })
    @id = data['id']
    @order_cost = data['order_cost']
    @amount = 0.05 * @order_cost
  end
end
