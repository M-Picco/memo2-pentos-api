require 'active_model'

class Client
  include ActiveModel::Validations

  attr_accessor :id, :name, :phone, :address, :updated_on, :created_on

  validates :name, presence: true

  def initialize(data = {})
    @id = data['id']
    @name = data['username']
    @phone = data['phone']
    @address = data['addres']
    @updated_on = data['updated_on']
    @created_on = data['created_on']
  end
end
