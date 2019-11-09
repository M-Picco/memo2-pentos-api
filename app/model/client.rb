require 'active_model'

class Client
  include ActiveModel::Validations

  attr_accessor :id, :name, :phone, :address, :updated_on, :created_on

  def initialize(data = {})
    @id = data[:id]
    @name = data[:name]
    @phone = data[:phone]
    @address = data[:address]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end
end
