class RainyWeather
  def name
    'lluvioso'
  end

  def apply_modifier(base_percentage)
    base_percentage + 0.01
  end

  def apply_time_modifier(time)
    time + 5
  end
end
