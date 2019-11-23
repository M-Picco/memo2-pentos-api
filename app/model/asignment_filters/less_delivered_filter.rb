class LessDeliveredFilter
  def apply(deliveries, _order)
    deliveries.min_by(&:delivered_count)
  end
end
