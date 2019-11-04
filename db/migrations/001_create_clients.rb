Sequel.migration do
  up do
    create_table(:clients) do
      primary_key :id
      String :name
      String :phone
    end
  end

  down do
    drop_table(:clients)
  end
end
