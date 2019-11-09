require 'active_model'

class Client
  include ActiveModel::Validations

  attr_accessor :id, :name, :phone, :address, :updated_on, :created_on

  VALID_NAME_REGEX = /\A[_A-z0-9]*((-)*[_A-z0-9])*\Z/.freeze

  validates :phone, presence: true
  validates :name, presence: true, format: { with: VALID_NAME_REGEX,
                                             message: 'invalid_username' }

  def initialize(data = {})
    @id = data['id']
    @name = data['username']
    @phone = data['phone']
    @address = data['addres']
    @updated_on = data['updated_on']
    @created_on = data['created_on']
  end
end
