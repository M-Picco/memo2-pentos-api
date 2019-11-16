Dado('el repartidor {string} que entrego {int} pedidos') do |nombre_repartidor, _int|
  step "el nombre del repartidor \"#{nombre_repartidor}\""
  step 'se registra'
end

Entonces('pedido esta asignado a {string} o a {string}') do |repartidor1, repartidor2|
  step 'consulta el estado'
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  assigned_to = parsed_response['assigned_to']
  expect([repartidor1, repartidor2].include?(assigned_to)).to eq true
end
