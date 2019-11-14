Cuando('el pedido es entregado por {string}') do |repartidor|
  step 'obtiene numero de pedido único'
  step 'el estado cambia a "en_entrega"'
  step "pedido esta asignado a \"#{repartidor}\""
  step 'el estado cambia a "entregado"'
end

Cuando('el cliente califica con {int}') do |calificacion|
  @rating = calificacion
  @request ||= {}
  @request['rating'] = @rating
  @response = Faraday.post(rate_order_url(@username, @order_id), @request.to_json, header)
end

Entonces('se registra la calificacion') do
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['rating']).to eq @rating
end

Entonces('pedido esta asignado a {string}') do |repartidor|
end

Entonces('recibe un error indicando que no puede calificar un pedido no entregado') do
  expect(@response.status).to eq(400)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['error']).to eq('order_not_delivered')
end

Cuando('el cliente califica con {int} un pedido inexistente') do |calificacion|
  @calificacion = calificacion
  @request ||= {}
  @request['rating'] = @calificacion
  order_id = 9999
  @response = Faraday.post(rate_order_url(@username, order_id), @request.to_json, header)
end
