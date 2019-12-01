require_relative '../errors/order_not_cancellable_error'
require_relative '../errors/invalid_parameter_error'
require_relative '../errors/invalid_operation_error'
require_relative '../states/state_factory'
require_relative '../states/recieved_state'
require_relative '../states/inpreparation_state'
require_relative '../states/ondelivery_state'
require_relative '../states/delivered_state'
require_relative '../states/cancelled_state'
require_relative '../states/state_names'
require_relative '../order_types/order_type_factory'

class Order
  attr_reader :state, :type, :rating
  attr_accessor :id, :client, :updated_on, :created_on, :assigned_to, :commission,
                :estimated_time, :delivered_on, :on_delivery_time

  ALLOWED_STATES = [STATES::RECEIVED, STATES::IN_PREPARATION,
                    STATES::ON_DELIVERY, STATES::DELIVERED,
                    STATES::CANCELLED, STATES::WAITING].freeze

  CANCELLABLE_STATES = [STATES::RECEIVED, STATES::IN_PREPARATION].freeze

  MIN_RATING = 1
  MAX_RATING = 5

  # rubocop:disable Metrics/AbcSize
  def initialize(data = {})
    @id = data[:id]

    raise InvalidParameterError, ERRORS::INVALID_CLIENT if data[:client].nil?

    @client = data[:client]

    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @state = data[:state] || RecievedState.new
    @rating = data[:rating]
    @assigned_to = data[:assigned_to]
    @weather = data[:weather]

    raise InvalidParameterError, ERRORS::INVALID_MENU if data[:type].nil?

    @type = data[:type]

    @commission = data[:commission]
    @delivered_on = data[:delivered_on]
    @on_delivery_time = data[:on_delivery_time]
  end
  # rubocop:enable Metrics/AbcSize

  def state=(new_state)
    valid_transition = ALLOWED_STATES.include?(new_state.state_name)

    raise InvalidParameterError, ERRORS::INVALID_STATE unless valid_transition

    @state = new_state
  end

  def change_state(new_state)
    self.state = new_state
    @state.on_enter(self)
  end

  def size
    @type.size
  end

  def cost
    @type.cost
  end

  def rating=(new_rating)
    raise InvalidOperationError, ERRORS::ORDER_NOT_DELIVERED if !new_rating.nil? &&
                                                                !@state.name?(STATES::DELIVERED)
    unless (MIN_RATING..MAX_RATING).include?(new_rating)
      raise InvalidParameterError, ERRORS::INVALID_RATING
    end

    @rating = new_rating

    return if @commission.nil?

    @commission.update_by_rating(new_rating)
    CommissionRepository.new.save(@commission)
  end

  def cancel
    raise OrderNotCancellableError unless CANCELLABLE_STATES.include?(@state.state_name)

    change_state(CancelledState.new)
  end

  def base_time
    @type.base_time
  end

  def duration
    (@delivered_on - @created_on) / 60.0 # in minutes
  end
end
