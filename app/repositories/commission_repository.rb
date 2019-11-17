require_relative 'base_repository'

class CommissionRepository < BaseRepository
  self.table_name = :commissions
  self.model_class = 'Commission'

  protected

  def changeset(commission)
    {
      amount: commission.amount,
      order_cost: commission.order_cost
    }
  end
end
