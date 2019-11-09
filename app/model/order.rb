require 'active_model'

class Order
  include ActiveModel::Validations
  attr_accessor :id, :client
  validates :id, :client, presence: true

  def initialize(data = {})
    @id = data['id']
    @client = data['client']
  end
end
