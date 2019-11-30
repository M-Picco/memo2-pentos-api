class Filter
  attr_accessor :next_filter

  def initialize
    raise ERRORS::SUBCLASS_RESPONSIBILITY
  end

  def run(deliveries, order)
    filtered_deliveries = apply(deliveries, order)
    run_next(filtered_deliveries, order)
  end

  def run_next(deliveries, order)
    @next_filter.run(deliveries, order)
  end

  def apply(_deliveries, _order)
    raise ERRORS::SUBCLASS_RESPONSIBILITY
  end
end
