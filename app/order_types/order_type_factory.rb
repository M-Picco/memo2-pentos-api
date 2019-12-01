require_relative './individual_order'

class OrderTypeFactory
  def create_for(_type_name)
    IndividualOrderType.new
  end
end
