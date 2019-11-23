require_relative '../repositories/delivery_repository'
require_relative '../repositories/order_repository'
require_relative '../repositories/delivery_repository.rb'
require_relative '../repositories/order_repository'
require_relative 'delivery_bag'
require_relative './asignment_filters/bag_fits_filter'
require 'date'

class DeliveryAssigner
  attr_reader :elegible_deliveries, :filter

  def initialize
    @filter = BagFitsFilter.new
  end

  def assign_to(order)
    deliveries = DeliveryRepository.new.deliveries
    order.assigned_to = @filter.run(deliveries, order).username
    OrderRepository.new.save(order)
  rescue NoMethodError
    order.assigned_to = nil
  end
end
