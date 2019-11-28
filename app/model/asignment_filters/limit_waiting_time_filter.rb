class LimitWaitingTimeFilter
  MAX_WAITING = 10

  def apply(deliveries, _orders)
    deliveries.select { |delivery| delivery.waiting_time < MAX_WAITING }
  end
end
