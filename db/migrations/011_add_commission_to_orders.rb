Sequel.migration do
  up do
    add_column :orders, :commission, Integer
  end

  down do
    drop_column :orders, :commission
  end
end
