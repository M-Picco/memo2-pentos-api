require 'active_model'

class Delivery
  include ActiveModel::Validations

  attr_accessor :id, :username, :updated_on, :created_on

  validates :username, presence: true, length: { minimum: 5 }

  def initialize(data = {})
    @id = data['id']
    @username = data['username']
    @updated_on = data['updated_on']
    @created_on = data['created_on']
  end
end
