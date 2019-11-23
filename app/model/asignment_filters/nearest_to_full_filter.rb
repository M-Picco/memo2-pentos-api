class NearestToFullFilter
  def apply(deliveries, _order)
    deliveries.group_by { |delivery| delivery.bag.size }.min.last
  end
end
