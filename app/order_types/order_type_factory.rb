require_relative './order_type_names'
require_relative './individual_order'
require_relative './couple_order'
require_relative './family_order'
require_relative '../errors/error_messages'

class OrderTypeFactory
  ORDER_TYPES = { ORDERTYPES::INDIVIDUAL_ORDER => IndividualOrderType,
                  ORDERTYPES::COUPLE_ORDER => CoupleOrderType,
                  ORDERTYPES::FAMILY_ORDER => FamilyOrderType }.freeze

  def create_for(type_name)
    raise InvalidParameterError, ERRORS::INVALID_MENU unless ORDER_TYPES.key?(type_name)

    ORDER_TYPES[type_name].new
  end
end