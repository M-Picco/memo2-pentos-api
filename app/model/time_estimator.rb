class TimeEstimator
  def estimate(order, weather)
    weather.apply_time_modifier(order.base_time)
  end
end
