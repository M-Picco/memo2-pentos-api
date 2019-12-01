require_relative './order_information'

class CoupleOrderType
  attr_reader :type_name, :size, :cost, :base_time

  def initialize
    @type_name = ORDERTYPES::COUPLE_ORDER
    @size = ORDERSIZE::COUPLE_ORDER
    @cost = ORDERCOSTS::COUPLE_ORDER
    @base_time = ORDERBASETIME::COUPLE_ORDER
  end
end
