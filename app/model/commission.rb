require_relative './weather/non_rainy_weather'

class Commission
  attr_accessor :id, :amount, :order_cost, :updated_on, :created_on, :weather

  ROUNDING_DIGITS = 2

  MIN_RATING = 1
  MAX_RATING = 5

  BASE_PERCENTAGE = 0.05
  RATING_MODIFIER = 0.02

  def initialize(data, weather)
    @id = data[:id]

    raise InvalidParameterError, 'invalid_cost' if (data[:order_cost] || 0).negative?

    @order_cost = data[:order_cost] || 0
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @weather = weather

    @amount = data[:amount] || calculate_amount_with_modifier(BASE_PERCENTAGE)
  end

  def update_by_rating(rating)
    modifier = BASE_PERCENTAGE

    modifier -= RATING_MODIFIER if rating == MIN_RATING
    modifier += RATING_MODIFIER if rating == MAX_RATING

    @amount = calculate_amount_with_modifier(modifier)
  end

  private

  def calculate_amount_with_modifier(modifier)
    final_modifier = @weather.apply_modifier(modifier)

    (final_modifier * @order_cost).round(ROUNDING_DIGITS)
  end
end
