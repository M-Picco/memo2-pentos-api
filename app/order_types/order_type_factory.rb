require_relative './order_type_names'

class OrderTypeFactory
  ORDER_TYPES = { ORDERTYPES::INDIVIDUAL_ORDER => IndividualOrderType,
                  ORDERTYPES::COUPLE_ORDER => CoupleOrderType,
                  ORDERTYPES::FAMILY_ORDER => FamilyOrderType }.freeze

  def create_for(type_name)
    raise InvalidParameterError, ERRORS::INVALID_MENU unless ORDER_TYPES.key?(type_name)

    ORDER_TYPES[type_name].new
  end
end
