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
