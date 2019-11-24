Sequel.migration do
  up do
    add_column :orders, :estimated_time, Integer
  end

  down do
    drop_column :orders, :estimated_time
  end
end
