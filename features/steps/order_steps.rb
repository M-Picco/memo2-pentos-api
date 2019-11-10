Dado('el repartidor {string}') do |string|
end

Cuando('el cliente pide un {string}') do |_menu|
  order_url = format(ORDER_BASE_URL, @request['username'])
  @response = Faraday.post(order_url, @request.to_json, header)
end

Entonces('obtiene numero de pedido único') do
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  @order_id = parsed_response['order_id']
  expect(@order_id).to be > 0 # rubocop:disable Style/NumericPredicate
end

Dado('que el cliente pidio un {string}') do |nombre_pedido|
  step "el cliente pide un \"#{nombre_pedido}\""
  step 'obtiene numero de pedido único'
end

Cuando('el estado cambia a {string}') do |new_status|
  @request = {}
  @request['status'] = new_status
  @response = Faraday.put(change_order_status_url(@order_id), @request.to_json, header)
end

Cuando('consulta el estado') do
  @response = Faraday.get(query_order_status_url(@username, @order_id), {}, header)
end

Entonces('el estado es {string}') do |expected_status|
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  order_status = parsed_response['order_status']
  expect(order_status).to eq(expected_status)
end

Dado('que el cliente no hizo pedidos') do
end

Cuando('consulta el estado de un pedido') do
  @response = Faraday.get(query_order_status_url(@username, 1), {}, header)
end

Entonces('obtiene un mensaje indicando que no realizo pedidos') do
  expect(@response.status).to eq(400)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['error']).to eq('there are no orders')
end
