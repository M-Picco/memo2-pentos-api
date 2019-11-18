Sequel.migration do
  up do
    add_column :orders, :assigned_to, String
  end

  down do
    drop_column :orders, :assigned_to
  end
end
