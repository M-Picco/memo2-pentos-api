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

Cuando('califica un pedido que no hizo el') do
  @current_client = @username
  step 'otro cliente'
  step 'que el cliente pidio un "menu_individual"'
  step 'el estado cambia a "entregado"'
  @username = @current_client
  step 'el cliente califica con 5'
end

Entonces('recibe un error indicando que la calificación es inválida') do
  expect(@response.status).to eq(400)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['error']).to eq('invalid_rating')
end
