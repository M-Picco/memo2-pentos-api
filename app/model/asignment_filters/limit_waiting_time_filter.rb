require_relative 'bag_fits_filter'
require_relative 'filter'

class LimitWaitingTimeFilter < Filter
  def initialize
    @next_filter = BagFitsFilter.new
  end

  MAX_WAITING = 10

  def apply(deliveries, _orders)
    deliveries.select { |delivery| delivery.waiting_time < MAX_WAITING }
  end
end
