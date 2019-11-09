Sequel.migration do
  up do
    add_column :clients, :address, String
  end

  down do
    drop_column :clients, :address
  end
end
