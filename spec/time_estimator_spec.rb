describe TimeEstimator do
  subject(:estimator) { described_class.new }

  let(:rainy_weather) { RainyWeather.new }
  let(:non_rainy_weather) { NonRainyWeather.new }

  let(:client) do
    Client.new('username' => 'jperez', 'phone' => '4123-4123',
               'address' => 'Av Paseo Colón 840')
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
end
