Sequel.migration do
  up do
    add_column :commissions, :created_on, Date
    add_column :commissions, :updated_on, Date
  end

  down do
    drop_column :commissions, :created_on
    drop_column :commissions, :updated_on
  end
end
