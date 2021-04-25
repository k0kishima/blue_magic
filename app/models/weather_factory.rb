class WeatherFactory
  def self.create!(name)
    case name
    when '晴', '晴れ'
      :fine
    when '雨'
      :rainy
    when '曇り', '曇', 'くもり'
      :cloudy
    when '雪'
      :snowy
    when '台風'
      :typhoon
    when '霧'
      :fog
    else
      raise NotImplementedError
    end
  end
end
