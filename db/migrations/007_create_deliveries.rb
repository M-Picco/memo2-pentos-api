Sequel.migration do
  up do
    create_table(:deliveries) do
      primary_key :id
      String :username
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:deliveries)
  end
end
