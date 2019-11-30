describe TimeEstimator do
  subject(:estimator) { described_class.new }

  let(:rainy_weather) { RainyWeather.new }
  let(:non_rainy_weather) { NonRainyWeather.new }
  let(:repository) { OrderRepository.new }

  let(:client) do
    Client.new(username: 'jperez', phone: '4123-4123',
               address: 'Av Paseo Colón 840')
  end

  it 'should estimate 20 minutes when order type is menu_individual' do
    order = Order.new(client: client, type: 'menu_individual')
    expect(estimator.estimate(order, non_rainy_weather)).to eq(20)
  end

  it 'should estimate 25 minutes when order type is menu_pareja' do
    order = Order.new(client: client, type: 'menu_pareja')
    expect(estimator.estimate(order, non_rainy_weather)).to eq(25)
  end

  it 'should estimate 30 minutes when order type is menu_familiar' do
    order = Order.new(client: client, type: 'menu_familiar')
    expect(estimator.estimate(order, non_rainy_weather)).to eq(30)
  end

  it 'should estimate 25 minutes when order type is menu_individual and its raining' do
    order = Order.new(client: client, type: 'menu_individual')
    expect(estimator.estimate(order, rainy_weather)).to eq(25)
  end

  it 'should be 30 minutes when order type is menu_pareja and its raining' do
    order = Order.new(client: client, type: 'menu_pareja')
    expect(estimator.estimate(order, rainy_weather)).to eq(30)
  end

  it 'should be 35 minutes when order type is menu_familiar and its raining' do
    order = Order.new(client: client, type: 'menu_familiar')
    expect(estimator.estimate(order, rainy_weather)).to eq(35)
  end

  # rubocop:disable RSpec/ExampleLength
  it 'should return the avg of the 3 last orders' do
    ClientRepository.new.save(client)
    order = Order.new(client: client, type: 'menu_individual')
    order.change_state(DeliveredState.new)

    order2 = Order.new(client: client, type: 'menu_individual')
    order2.change_state(DeliveredState.new)

    order3 = Order.new(client: client, type: 'menu_individual')
    order3.change_state(DeliveredState.new)

    repository.save(order)
    repository.save(order2)
    repository.save(order3)

    reloaded_order = repository.find_by_id(order.id)
    reloaded_order2 = repository.find_by_id(order2.id)
    reloaded_order3 = repository.find_by_id(order3.id)

    reloaded_order.delivered_on = reloaded_order.created_on + (60 * 5)
    reloaded_order2.delivered_on = reloaded_order2.created_on + (60 * 10)
    reloaded_order3.delivered_on = reloaded_order3.created_on + (60 * 15)

    repository.save(reloaded_order)
    repository.save(reloaded_order2)
    repository.save(reloaded_order3)

    new_order = Order.new(client: client, type: 'menu_individual')
    expect(estimator.estimate(new_order, rainy_weather)).to eq(10)
  end
  # rubocop:enable RSpec/ExampleLength
end
