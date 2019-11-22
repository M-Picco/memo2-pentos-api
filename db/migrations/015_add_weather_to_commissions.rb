Sequel.migration do
  up do
    add_column :commissions, :weather, String
    from(:commissions).update(weather: 'no_lluvioso')
  end

  down do
    drop_column :commissions, :weather
  end
end
