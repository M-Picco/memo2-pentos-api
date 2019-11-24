Given('client orders a {string}') do |menu|
  @request = { 'item': menu }
end

When('the client submits the order') do
  @response = Faraday.post(SUBMIT_ORDER_URL, @request.to_json, 'Content-Type' => 'application/json')
end

When('the client queries the order status') do
  order_id = @order_submitted['id']
  @response = Faraday.get(QUERY_ORDER_URL + '/' + order_id.to_s)
end

Given('client has submitted an order for a {string}') do |menu|
  step "client orders a \"#{menu}\""
  step 'the client submits the order'
  @order_submitted = JSON.parse(@response.body)
end

When('the client cancels the order') do
  order_id = @order_submitted['id']
  @response = Faraday.put(cancel_order_url(order_id))
end

And('the order id is {int}') do |order_id|
  response = JSON.parse(@response.body)
  expect(response['id']).to eq(order_id)
end

And('the order status is {string}') do |status|
  response = JSON.parse(@response.body)
  expect(response['status']).to eq(status)
end

When('the order status is changed to {string}') do |new_status|
  order_id = @order_submitted['id']
  @response = Faraday.put(change_order_status_url(order_id, new_status))
end
