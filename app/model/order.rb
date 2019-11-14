require 'active_model'

class Order
  include ActiveModel::Validations
  attr_reader :state
  attr_accessor :id, :client, :updated_on, :created_on, :rating
  validates :client, presence: true

  validate :valid_state, :valid_state_for_rating

  ALLOWED_STATES = %w[recibido en_preparacion en_entrega entregado].freeze

  def initialize(data = {})
    @id = data[:id]
    @client = data[:client]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @state = data[:state] || 'recibido'
  end

  def state=(new_state)
    valid_transition = ALLOWED_STATES.include?(new_state)
    @state = valid_transition ? new_state : 'invalid_state'
  end

  private

  def valid_state
    valid_state = @state != 'invalid_state'
    errors.add(:state, 'invalid state') unless valid_state
  end

  def valid_state_for_rating
    errors.add(:state_for_rating, 'order_not_delivered') if !@rating.nil? && @state != 'entregado'
  end
end
