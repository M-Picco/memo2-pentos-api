require 'time'

When(/^se consultan los pedidos historicos$/) do
  time = Time.new
  @date = time.year.to_s + '-' + time.month.to_s + '-' + time.day.to_s
  @response = Faraday.get(historical_orders_url(@username), {}, header)
  expect(@response.status).to eq 200
end

When(/^hay un pedido de "([^"]*)" con id unico entregado por "([^"]*)" con fecha correcta$/) do |menu, delivery|
  parsed_response = JSON.parse(@response.body)
  expect(some_order_match(parsed_response, menu, delivery, @date)).to eq true
end

When(/^hay un solo pedido historico$/) do
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response.size).to eq 1
end

def some_order_match(orders, menu, delivery, date)
  orders.each do |order|
    if order['menu'] == menu && order['assigned_to'] == delivery &&
       order['date'] <= date && order['id'].positive?
      return true
    end
  end
  false
end

When(/^no hay ningun pedido en el registro$/) do
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response.size).to eq 0
end

When(/^hay dos pedidos historicos$/) do
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response.size).to eq 2
end
