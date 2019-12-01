require_relative './order_information'

class IndividualOrderType
  attr_reader :type_name, :size, :cost, :base_time

  def initialize
    @type_name = ORDERTYPES::INDIVIDUAL_ORDER
    @size = ORDERSIZE::INDIVIDUAL_ORDER
    @cost = ORDERCOSTS::INDIVIDUAL_ORDER
    @base_time = ORDERBASETIME::INDIVIDUAL_ORDER
  end
end
