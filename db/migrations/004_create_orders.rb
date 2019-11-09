require_relative '../../app/model/client'

Sequel.migration do
  up do
    create_table(:orders) do
      primary_key :id
      String :client_username
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:orders)
  end
end
