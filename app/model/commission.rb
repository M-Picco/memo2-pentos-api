require 'active_model'
require_relative './weather/non_rainy_weather'

class Commission
  include ActiveModel::Validations

  attr_accessor :id, :amount, :order_cost, :updated_on, :created_on, :weather

  validates :order_cost, numericality: { greater_than_or_equal_to: 0 }

  ROUNDING_DIGITS = 2

  BASE_PERCENTAGE = 0.05
  RATING_MODIFIER = 0.02

  def initialize(data, weather)
    @id = data[:id]
    @order_cost = data[:order_cost] || 0
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @weather = weather

    @amount = data[:amount] || calculate_amount_with_modifier(BASE_PERCENTAGE)
  end

  def update_by_rating(rating)
    modifier = BASE_PERCENTAGE

    modifier -= RATING_MODIFIER if rating == 1
    modifier += RATING_MODIFIER if rating == 5

    @amount = calculate_amount_with_modifier(modifier)
  end

  private

  def calculate_amount_with_modifier(modifier)
    final_modifier = @weather.apply_commission_modifier(modifier)

    (final_modifier * @order_cost).round(ROUNDING_DIGITS)
  end
end
