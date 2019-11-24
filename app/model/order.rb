require 'active_model'
require_relative '../errors/invalid_menu_error'
require_relative '../errors/order_not_cancellable_error'
require_relative '../states/state_factory'
require_relative '../states/recieved_state'
require_relative '../states/inpreparation_state'
require_relative '../states/ondelivery_state'
require_relative '../states/delivered_state'
require_relative '../states/invalid_state'
require_relative '../states/cancelled_state'
require_relative '../states/state_names'

class Order
  include ActiveModel::Validations
  attr_reader :state, :type, :rating
  attr_accessor :id, :client, :updated_on, :created_on, :assigned_to, :commission,
                :estimated_time
  validates :client, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 1,
                                     less_than_or_equal_to: 5,
                                     message: 'invalid_rating' },
                     allow_nil: true

  validate :valid_state, :valid_state_for_rating

  ALLOWED_STATES = [STATES::RECEIVED, STATES::IN_PREPARATION,
                    STATES::ON_DELIVERY, STATES::DELIVERED,
                    STATES::CANCELLED, STATES::WAITING].freeze

  CANCELLABLE_STATES = [STATES::RECEIVED, STATES::IN_PREPARATION].freeze

  ORDERS_SIZE = { 'menu_individual' => 1,
                  'menu_pareja' => 2,
                  'menu_familiar' => 3 }.freeze

  VALID_TYPES = { 'menu_individual' => 100, 'menu_pareja' => 175, 'menu_familiar' => 250 }.freeze

  BASE_TIME = { 'menu_individual' => 20,
                'menu_pareja' => 25,
                'menu_familiar' => 30 }.freeze

  # rubocop:disable Metrics/AbcSize
  def initialize(data = {})
    @id = data[:id]
    @client = data[:client]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @state = RecievedState.new
    @rating = data[:rating]
    @assigned_to = data[:assigned_to]

    raise InvalidMenuError unless VALID_TYPES.key?(data[:type])

    @weather = data[:weather]
    @type = data[:type]
    @commission = data[:commission]
    @estimated_time = data[:estimated_time] || calculate_estimated
  end
  # rubocop:enable Metrics/AbcSize

  def state=(new_state)
    valid_transition = ALLOWED_STATES.include?(new_state.state_name)
    @state = valid_transition ? new_state : InvalidState.new
  end

  def change_state(new_state)
    self.state = new_state
    @state.on_enter(self)
  end

  def size
    ORDERS_SIZE[@type]
  end

  def cost
    VALID_TYPES[@type]
  end

  def rating=(new_rating)
    @rating = new_rating

    return if @commission.nil?

    @commission.update_by_rating(new_rating)
    CommissionRepository.new.save(@commission)
  end

  def cancel
    raise OrderNotCancellableError unless CANCELLABLE_STATES.include?(@state.state_name)

    change_state(CancelledState.new)
  end

  def calculate_estimated
    if @weather
      @weather.apply_time_modifier(BASE_TIME[@type])
    else
      BASE_TIME[@type]
    end
  end

  def base_time
    BASE_TIME[@type]
  end

  private

  def valid_state
    valid_state = !@state.name?(STATES::INVALID)
    errors.add(:state, 'invalid_state') unless valid_state
  end

  def valid_state_for_rating
    return errors.add(:state_for_rating, 'order_not_delivered') if !@rating.nil? &&
                                                                   !@state.name?(STATES::DELIVERED)
  end
end
