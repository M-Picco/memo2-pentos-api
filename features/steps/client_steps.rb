Given('client username is {string}') do |name|
  @request ||= {}
  @request['username'] = name
end

And('client address is {string}') do |address|
  @request ||= {}
  @request['address'] = address
end

And('client phone number is {string}') do |phone|
  @request ||= {}
  @request['phone'] = phone
end

Given('client {string} with address {string} and phone {string} exists') do |name, address, phone|
  step "client username is \"#{name}\""
  step "client address is \"#{address}\""
  step "client phone number is \"#{phone}\""
  step 'the client registers'
  @client = JSON.parse(@response.body)
end

When('the client registers') do
  @response = Faraday.post(REGISTER_CLIENT_URL, @request.to_json, 'Content-Type' => 'application/json')
end

And('the client id is {int}') do |client_id|
  response = JSON.parse(@response.body)
  expect(response['id']).to eq(client_id)
end
