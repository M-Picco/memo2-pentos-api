require 'active_model'
require_relative './weather/non_rainy_weather'

class Commission
  include ActiveModel::Validations

  attr_accessor :id, :amount, :order_cost, :updated_on, :created_on, :weather

  validates :order_cost, numericality: { greater_than_or_equal_to: 0 }

  BASE_PERCENTAGE = 0.05
  MIN_PERCENTAGE = 0.03
  MAX_PERCENTAGE = 0.07

  def initialize(data, weather)
    @id = data[:id]
    @order_cost = data[:order_cost] || 0
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @weather = weather

    percentage = @weather.apply_commission_modifier(BASE_PERCENTAGE)
    @amount = data[:amount] || percentage * @order_cost
  end

  def update_by_rating(rating)
    @amount = MIN_PERCENTAGE * @order_cost if rating == 1
    @amount = MAX_PERCENTAGE * @order_cost if rating == 5
  end
end
