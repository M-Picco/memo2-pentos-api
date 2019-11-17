Cuando('no llueve') do
  @request['rain'] = false
  @response = Faraday.post(WEATHER_URL, @request.to_json, header)
  expect(@response.status).to eq(200)
end

Entonces('la comision {float}') do |comision|
  @response = Faraday.post(query_commission_url(@order_id), @request.to_json, header)
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['commission_amount']).to eq comision
end
