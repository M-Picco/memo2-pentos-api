class WaitingTimeFilter
  def apply(deliveries, _orders)
    repository = OrderRepository.new
    date = Time.now.round
    deliveries.map do |delivery|
      last_order = repository.last_on_delivery_by(delivery.username)
      delivery.waiting_time = (date - last_order.on_delivery_time) / 60.0
    rescue DeliveryHasNoOrdersError
      delivery.waiting_time = 0
    end
    deliveries
  end
end
