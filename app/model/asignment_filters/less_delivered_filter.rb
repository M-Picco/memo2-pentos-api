require_relative 'filter'

class LessDeliveredFilter < Filter
  def initialize; end

  def apply(deliveries, _order)
    deliveries.min_by(&:delivered_count)
  end

  def run_next(delivery, _order)
    delivery
  end
end
