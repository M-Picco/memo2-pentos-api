require 'integration_spec_helper'

describe CommissionRepository do
  let(:repository) { described_class.new }

  it 'create new commission' do
    commission = Commission.new(order_cost: 100)
    repository.save(commission)
    expect(commission.id).to be > 0
  end
end
