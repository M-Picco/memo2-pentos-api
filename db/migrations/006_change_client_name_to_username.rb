Sequel.migration do
  up do
    rename_column :clients, :name, :username
  end

  down do
    rename_column :clients, :username, :name
  end
end
