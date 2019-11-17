Dado('el cliente {string}') do |username|
  @username = username
  @request ||= {}
  @request['username'] = username
end

Cuando('se registra con domicilio {string} y telefono {string}') do |address, phone|
  @request ||= {}
  @request['address'] = address
  @request['phone'] = phone
  @response = Faraday.post(CLIENT_BASE_URL, @request.to_json, header)
end

Entonces('obtiene un numero unico de cliente') do
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  @client_id = parsed_response['client_id']
  expect(@client_id).to be > 0 # rubocop:disable Style/NumericPredicate
end

Dado('el repartidor {string}') do |username|
  @request ||= {}
  @request['username'] = username
end

Cuando('se registra') do
  @response = Faraday.post(REGISTER_DELIVERY_URL, @request.to_json, header)
end

Dado('el repartidor {string} está registrado') do |username|
  step "el repartidor \"#{username}\""
  step 'se registra'
end

Entonces('obtiene un numero unico de repartidor') do
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['delivery_id']).to be > 0 # rubocop:disable Style/NumericPredicate
end

Entonces('obtiene un mensaje de error por nombre de usuario inválido') do
  expect(@response.status).to eq(400)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['error']).to eq('invalid_username')
end

Entonces('obtiene un mensaje de error por número de teléfono inválido') do
  expect(@response.status).to eq(400)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['error']).to eq('invalid_phone')
end

Entonces('obtiene un mensaje de error por domicilio inválido') do
  expect(@response.status).to eq(400)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['error']).to eq('invalid_address')
end

Pero('no hay repartidor disponible') do
  # Do nothing
end

Entonces('obtiene un error por nombre de usuario invalido') do
  expect(@response.status).to eq(400)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['error']).to eq('invalid_username')
end

Entonces('obtiene error por no estar registrado') do
  expect(@response.status).to eq(400)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['error']).to eq('not_registered')
end

Dado('que el repartidor {string} esta registrado') do |username|
  step "el repartidor \"#{username}\""
  step 'se registra'
end

Dado('que el cliente {string} esta registrado con
      domicilio {string} y telefono {string}') do |username, address, phone|
  step "el cliente \"#{username}\""
  step "se registra con domicilio \"#{address}\" y telefono \"#{phone}\""
end

Entonces('obtiene un mensaje de error por ya estar registrado') do
  expect(@response.status).to eq(400)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['error']).to eq('already_registered')
end
