require_relative 'base_repository'

class DeliveryRepository < BaseRepository
  self.table_name = :deliveries
  self.model_class = 'Delivery'

  protected

  def changeset(delivery)
    {
      username: delivery.username
    }
  end
end
