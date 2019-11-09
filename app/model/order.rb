require 'active_model'

class Order
  include ActiveModel::Validations
  attr_accessor :id, :client, :updated_on, :created_on, :state
  validates :client, presence: true

  def initialize(data = {})
    @id = data['id']
    @client = data['client']
    @updated_on = data['updated_on']
    @created_on = data['created_on']
    @state = data['state'] || 'recibido'
  end
end
