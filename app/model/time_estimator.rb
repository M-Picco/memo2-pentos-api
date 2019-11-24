class TimeEstimator
  AVRAGE_DELIVERY_TIME = 10

  def estimate(order, weather)
    weather.apply_time_modifier(order.base_time) + AVRAGE_DELIVERY_TIME
  end
end
