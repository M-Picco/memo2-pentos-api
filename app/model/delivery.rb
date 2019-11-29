require 'active_model'

class Delivery
  include ActiveModel::Validations

  attr_accessor :id, :username, :updated_on, :created_on, :bag, :delivered_count,
                :waiting_time

  validates :username, presence: { message: 'invalid_username' },
                       length: { minimum: 5, maximum: 19, message: 'invalid_username' }
  def initialize(data = {})
    @id = data[:id]
    @username = data[:username]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @delivered_count = data[:delivered_count] || 0
    @waiting_time = data[:waiting_time] || 0
  end
end
