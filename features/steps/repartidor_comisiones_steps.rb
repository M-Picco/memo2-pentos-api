Cuando('el pedido es entregado por {string}') do |repartidor|
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

Cuando('no llueve') do
  @request['rain'] = false
  @response = Faraday.post(WEATHER_URL, @request.to_json, header)
  expect(response.status).to eq(200)
end

Entonces('se registra la calificacion') do
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['rating']).to eq @rating
end

Entonces('la comision {float}') do |comision|
  response = Faraday.post(query_commission_url(@order_id), @request.to_json, header)
  expect(response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['comission_amount']).to be eq comision
end

Cuando('llueve') do
  @request['rain'] = true
  @response = Faraday.post(WEATHER_URL, @request.to_json, header)
  expect(response.status).to eq(200)
end
