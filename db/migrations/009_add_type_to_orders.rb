Sequel.migration do
  up do
    add_column :orders, :type, String
  end

  down do
    drop_column :orders, :type
  end
end
