class Race < ApplicationRecord
  include StadiumAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number]

  NUMBER_OF_DAILY = 12
  def self.numbers = (1..NUMBER_OF_DAILY).to_a

  has_many :race_entries, foreign_key: self.primary_keys
  has_many :weather_conditions, foreign_key: self.primary_keys
  has_many :payoffs, foreign_key: self.primary_keys
  has_many :odds, foreign_key: self.primary_keys, class_name: 'Odds'

  validates :date, presence: true
  validates :race_number, presence: true, inclusion: { in: self.numbers }
  validates :title, presence: true
  validates :course_fixed, inclusion: { in: [true, false] }
  validates :use_stabilizer, inclusion: { in: [true, false] }
  validates :number_of_laps, presence: true, inclusion: { in: [2, 3] }
  validates :betting_deadline_at, presence: true
  validate :betting_deadline_at_cannot_be_no_in_date

  class << self
    def by_wind_condition(wind_angle:, wind_velocity:)
      joins(:weather_conditions)
        .merge(WeatherCondition.where(wind_angle: wind_angle, wind_velocity: wind_velocity))
    end

    def by_wind_condition_in_performance(wind_angle:, wind_velocity:)
      by_wind_condition(wind_angle: wind_angle, wind_velocity: wind_velocity)
        .merge(WeatherCondition.where(in_performance: true))
    end

    def by_wind_condition_in_exhibition(wind_angle:, wind_velocity:)
      by_wind_condition(wind_angle: wind_angle, wind_velocity: wind_velocity)
        .merge(WeatherCondition.where(in_performance: false))
    end
  end

  def winner
    @winner ||= race_entries
                .find { |race_entry| race_entry&.race_record&.winning_race_entry.present? }
      &.race_record
      &.winning_race_entry
  end

  def event
    @event ||= Event
               .where(stadium_tel_code: stadium_tel_code)
               .where('starts_on <= ?', date)
               .last
  end

  def race_status
    status.upcase
  end

  def series_grade
    event.grade.upcase
  end

  def series_kind
    event.kind.upcase
  end

  def day_count_in_event
    @day_count_in_event ||= self.class
                                .not_canceled
                                .where(stadium_tel_code: stadium_tel_code)
                                .where("date >= ?", event.starts_on)
                                .where("date <= ?", date)
                                .group(:date)
                                .count
                                .keys
                                .count
  end

  def odds_for(pit_number)
    odds.select { |o| o.betting_number.to_s.first.to_i == pit_number }
  end

  def odds_mean
    odds.map(&:ratio).mean
  end

  def odds_sd
    odds.map(&:ratio).sd
  end

  private

  def betting_deadline_at_cannot_be_no_in_date
    return if date&.all_day&.cover?(betting_deadline_at)

    errors.add(:betting_deadline_at, 'must be with in same date  of value of date property')
  end
end

# == Schema Information
#
# Table name: races
#
#  stadium_tel_code    :integer          not null, primary key
#  date                :date             not null, primary key
#  race_number         :integer          not null, primary key
#  title               :string(255)      not null
#  course_fixed        :boolean          default(FALSE), not null
#  use_stabilizer      :boolean          default(FALSE), not null
#  number_of_laps      :integer          default(3), not null
#  betting_deadline_at :datetime         not null
#  canceled            :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_races_on_betting_deadline_at  (betting_deadline_at)
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
