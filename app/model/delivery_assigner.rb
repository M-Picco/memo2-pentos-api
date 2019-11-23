require_relative '../repositories/delivery_repository'
require_relative '../repositories/order_repository'
require_relative '../repositories/delivery_repository.rb'
require_relative '../repositories/order_repository'
require_relative 'delivery_bag'
require_relative './asignment_filters/bag_fits_filter'
require_relative '../states/waiting_state'
require 'date'

class DeliveryAssigner
  attr_reader :elegible_deliveries, :filter

  def initialize
    @filter = BagFitsFilter.new
  end

  def assign_to(order)
    deliveries = DeliveryRepository.new.deliveries
    elected_delivery = @filter.run(deliveries, order)
    order.assigned_to = elected_delivery.username
  rescue NoDeliveryAvailableError
    order.assigned_to = elected_delivery
    order.change_state(WaitingState.new)
  ensure
    OrderRepository.new.save(order)
  end
end
