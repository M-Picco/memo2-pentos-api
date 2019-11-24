require 'integration_spec_helper'

describe CommissionRepository do
  let(:repository) { described_class.new }

  it 'create new commission' do
    commission = Commission.new({ order_cost: 100 }, NonRainyWeather.new)
    repository.save(commission)
    expect(commission.id).to be > 0
  end

  describe 'find_by_id' do
    it 'saves a commission with rainy weather and loads it' do
      commission = Commission.new({ order_cost: 100 }, RainyWeather.new)
      repository.save(commission)

      reloaded_commission = repository.find_by_id(commission.id)

      expect(reloaded_commission.weather).to be_a(RainyWeather)
    end

    it 'returns a NullCommission if no commissions are found' do
      commission = repository.find_by_id(-1)

      expect(commission).to be_a(NullCommission)
    end
  end
end
