Sequel.migration do
  up do
    add_column :orders, :on_delivery_time, DateTime
  end

  down do
    drop_column :orders, :on_delivery_time
  end
end
