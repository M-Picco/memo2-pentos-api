require 'active_model'

class Client
  include ActiveModel::Validations

  attr_accessor :id, :name, :phone, :address, :updated_on, :created_on

  VALID_NAME_REGEX = /\A[_A-z0-9]*((-)*[_A-z0-9])*\Z/.freeze
  VALID_PHONE_REGEX = /\A(\d)+-?(\d)+\Z/.freeze

  validates :phone, presence: true, format: { with: VALID_PHONE_REGEX,
                                              message: 'invalid_phone' }
  validates :name, presence: true, format: { with: VALID_NAME_REGEX,
                                             message: 'invalid_username' }
  validates :address, presence: true, length: { minimum: 5, message: 'invalid_address' }

  def initialize(data = {})
    @id = data['id'] || data[:id]
    @name = data['username'] || data[:username]
    @phone = data['phone']
    @address = data['address']
    @updated_on = data['updated_on']
    @created_on = data['created_on']
  end

  def username?(username)
    @name == username
  end
end
