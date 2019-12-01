require_relative './order_information'

class FamilyOrderType
  attr_reader :type_name, :size, :cost, :base_time

  def initialize
    @type_name = ORDERTYPES::FAMILY_ORDER
    @size = ORDERSIZE::FAMILY_ORDER
    @cost = ORDERCOSTS::FAMILY_ORDER
    @base_time = ORDERBASETIME::FAMILY_ORDER
  end
end
