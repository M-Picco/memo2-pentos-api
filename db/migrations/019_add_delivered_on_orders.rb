Sequel.migration do
  up do
    add_column :orders, :delivered_on, DateTime
  end

  down do
    drop_column :orders, :delivered_on
  end
end
