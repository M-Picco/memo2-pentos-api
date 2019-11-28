Dado('el repartidor {string} que entrego {int} pedidos') do |nombre_repartidor, cantidad_pedidos|
  step "el repartidor \"#{nombre_repartidor}\" está registrado"
  if cantidad_pedidos > 0 # rubocop:disable Style/NumericPredicate
    step 'que el cliente pidio un "menu_familiar"'
    step 'el estado cambia a "en_preparacion"'
    step 'el estado cambia a "en_entrega"'
    step 'el estado cambia a "entregado"'
  end
end

Entonces('pedido esta asignado a {string}') do |repartidor|
  step 'consulta el estado'
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  assigned_to = parsed_response['assigned_to']
  expect(assigned_to).to eq(repartidor)
end

Entonces('pedido esta asignado a {string} o a {string}') do |repartidor1, repartidor2|
  step 'consulta el estado'
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  assigned_to = parsed_response['assigned_to']
  expect([repartidor1, repartidor2].include?(assigned_to)).to eq true
end

Cuando('{string} pasa {int} minutos esperando el llenado de su bolso') do |repartidor, minutos|
  @request = {}
  @request['minutes'] = minutos
  Faraday.put(waiting_time_url(repartidor), @request.to_json, header)
end
