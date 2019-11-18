Sequel.migration do
  up do
    create_table(:commissions) do
      primary_key :id
      Integer :order_cost
      Integer :amount
    end
  end

  down do
    drop_table(:commissions)
  end
end
