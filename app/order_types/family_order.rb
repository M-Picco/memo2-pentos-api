class FamilyOrderType
  attr_reader :type_name, :size, :cost, :base_time

  def initialize
    @type_name = 'menu_familiar'
    @size = 3
    @cost = 250
    @base_time = 20
  end
end
