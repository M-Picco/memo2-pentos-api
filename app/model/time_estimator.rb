class TimeEstimator
  AVRAGE_DELIVERY_TIME = 10
  TOP_ORDERS = 3

  def estimate(order, weather)
    repository = OrderRepository.new
    last_orders = repository.last_delivered_orders(order.type, TOP_ORDERS)

    return basic_estimation(order, weather) if last_orders.size < TOP_ORDERS

    # avg order's duration
    last_orders.map(&:duration).reduce(:+) / TOP_ORDERS.to_f
  end

  def basic_estimation(order, weather)
    weather.apply_time_modifier(order.base_time) + AVRAGE_DELIVERY_TIME
  end
end
