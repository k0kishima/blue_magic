class RecommendOdds < Odds
  attribute :recommended_by, :integer
  attribute :date, :date
  attribute :stadium_tel_code, :integer
  attribute :race_number, :integer
  attribute :betting_number, :integer
  attribute :ratio, :float

  validates :recommended_by, presence: true
  validates :stadium_tel_code, presence: true
  validates :race_number, presence: true
  validates :betting_number, presence: true
  validates :ratio, presence: true

  def betting_numbers
    betting_number.to_s.split('').map(&:to_i)
  end

  def first
    betting_numbers.first
  end

  def second
    betting_numbers.second
  end

  def third
    betting_numbers.third
  end

  # todo: 3連単以外の式別に対応する必要が生じた時点で修正する
  def betting_method
    :trifecta
  end
end
