class Order
  attr_accessor :id, :client

  def initialize(data = {})
    @id = data['id']
    @client = data['client']
  end
end
