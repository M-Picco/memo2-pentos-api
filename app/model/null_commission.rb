require_relative '../errors/order_not_delivered_error'
require_relative './weather/non_rainy_weather'

class NullCommission
  def amount
    raise OrderNotDeliveredError
  end

  def weather
    NonRainyWeather.new
  end

  def id
    -1
  end

  def update_by_rating(_rating); end
end
