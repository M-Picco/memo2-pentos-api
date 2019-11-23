class BagFitsFilter
  def apply(deliveries, order)
    deliveries.map do |delivery|
      delivery_orders = OrderRepository.new.on_delivery_orders_by(delivery.username)
      delivery.bag = DeliveryBag.new
      delivery.bag.load_orders_from_collection(delivery_orders)
    end
    deliveries.select { |delivery| delivery.bag.fits?(order) }
  end
end
