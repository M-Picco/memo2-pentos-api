require_relative 'limit_waiting_time_filter'
require_relative 'filter'

class WaitingTimeFilter < Filter
  def initialize
    @next_filter = LimitWaitingTimeFilter.new
  end

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
