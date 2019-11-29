class Delivery
  attr_accessor :id, :username, :updated_on, :created_on, :bag, :delivered_count,
                :waiting_time

  MIN_USER_LENGTH = 5
  MAX_USER_LENGTH = 19

  def initialize(data = {})
    @id = data[:id]

    raise InvalidParameterError, 'invalid_username' unless valid_username?(data[:username])

    @username = data[:username]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @delivered_count = data[:delivered_count] || 0
    @waiting_time = data[:waiting_time] || 0
  end

  private

  def valid_username?(username)
    !username.blank? && (MIN_USER_LENGTH..MAX_USER_LENGTH).include?(username.size)
  end
end
