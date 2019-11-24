require_relative 'delivered_count_filter'
require_relative 'filter'
require_relative '../../errors/no_delivery_available_error'

class NearestToFullFilter < Filter
  def initialize
    @next_filter = DeliveredCountFilter.new
  end

  def apply(deliveries, _order)
    raise NoDeliveryAvailableError if deliveries.size.zero?

    deliveries.group_by { |delivery| delivery.bag.size }.min.last
  end
end
