Sequel.migration do
  up do
    add_column :clients, :created_on, Date
    add_column :clients, :updated_on, Date
  end

  down do
    drop_column :clients, :created_on
    drop_column :clients, :updated_on
  end
end
