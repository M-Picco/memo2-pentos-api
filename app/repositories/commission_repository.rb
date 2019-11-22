require_relative 'base_repository'
require_relative '../model/weather/weather_factory'

class CommissionRepository < BaseRepository
  self.table_name = :commissions
  self.model_class = 'Commission'

  protected

  def load_object(a_record)
    weather = WeatherFactory.new.create_for(a_record[:weather])
    Commission.new(a_record, weather)
  end

  def changeset(commission)
    {
      amount: commission.amount,
      order_cost: commission.order_cost,
      weather: commission.weather.name
    }
  end
end
