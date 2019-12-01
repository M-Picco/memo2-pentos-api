class CoupleOrderType
  attr_reader :type_name, :size, :cost, :base_time

  def initialize
    @type_name = 'menu_pareja'
    @size = 2
    @cost = 175
    @base_time = 15
  end
end
