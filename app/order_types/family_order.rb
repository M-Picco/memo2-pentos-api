class FamilyOrderType
  attr_reader :type_name, :size, :cost, :base_time

  def initialize
    @type_name = ORDERTYPES::FAMILY_ORDER
    @size = 3
    @cost = 250
    @base_time = 20
  end
end
