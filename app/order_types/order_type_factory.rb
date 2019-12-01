require_relative './individual_order'

class OrderTypeFactory
  def create_for(type_name)
    return CoupleOrderType.new if type_name == 'menu_pareja'
    return FamilyOrderType.new if type_name == 'menu_familiar'

    IndividualOrderType.new
  end
end
