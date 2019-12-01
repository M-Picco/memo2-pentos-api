class IndividualOrderType
  attr_reader :type_name, :size, :cost, :base_time

  def initialize
    @type_name = ORDERTYPES::INDIVIDUAL_ORDER
    @size = 1
    @cost = 100
    @base_time = 10
  end
end
