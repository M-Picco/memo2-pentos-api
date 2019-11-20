Sequel.migration do
  up do
    add_column :orders, :state, String
  end

  down do
    drop_column :orders, :state
  end
end
