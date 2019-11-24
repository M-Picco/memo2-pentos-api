require_relative 'base_repository'

class DeliveryRepository < BaseRepository
  self.table_name = :deliveries
  self.model_class = 'Delivery'

  def deliveries
    load_collection dataset
  end

  def exists?(delivery_username)
    dataset.where(username: delivery_username).count.positive?
  end

  protected

  def changeset(delivery)
    {
      username: delivery.username
    }
  end
end
