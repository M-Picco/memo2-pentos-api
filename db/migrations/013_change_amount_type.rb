Sequel.migration do
  up do
    alter_table(:commissions) do
      set_column_type :amount, :float
    end
  end

  down do
    alter_table(:commissions) do
      set_column_type :amount, :integer
    end
  end
end
