class DeliveredCountFilter
  def apply(deliveries, _order)
    orders_repo = OrderRepository.new
    day = Date.today
    deliveries.map do |delivery|
      q = orders_repo.delivered_count_for(delivery.username, day)
      delivery.delivered_count = q
    end

    deliveries
  end
end
