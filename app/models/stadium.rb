class Stadium < ApplicationRecord
  TELCODE_RANGE = 1..24

  self.table_name = :stadiums
  self.primary_key = :tel_code

  enum water_quality: { fresh: 1, brackish: 2, sea: 3, }

  validates :tel_code, presence: true, inclusion: { in: TELCODE_RANGE }, uniqueness: true
  validates :name, presence: true
  validates :prefecture_id, presence: true
  validates :water_quality, presence: true
  validates :tide_fluctuation, inclusion: { in: [true, false] }
  validates :lat, presence: true
  validates :lng, presence: true
  validates :elevation, presence: true

  def self.all_tel_codes
    TELCODE_RANGE.to_a
  end
end
