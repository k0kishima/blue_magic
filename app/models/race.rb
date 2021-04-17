class Race < ApplicationRecord
  include StadiumAssociating

  NUMBER_OF_DAILY = 12

  enum status: { on_going: 1, done: 2, canceled: 3, }

  self.primary_keys = [:stadium_tel_code, :date, :race_number]

  has_many :race_entries, foreign_key: self.primary_keys
  has_many :weather_conditions, foreign_key: self.primary_keys
  has_many :payoffs, foreign_key: self.primary_keys
  has_many :odds, foreign_key: self.primary_keys, class_name: 'Odds'

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

    def numbers
      (1..NUMBER_OF_DAILY).to_a
    end
  end

  validates :date, presence: true
  validates :race_number, presence: true, inclusion: { in: self.numbers }
  validates :status, presence: true
  validates :title, presence: true
  validates :course_fixed, inclusion: { in: [true, false] }
  validates :use_stabilizer, inclusion: { in: [true, false] }
  validates :number_of_laps, presence: true, inclusion: { in: [2, 3] }
  validates :betting_deadline_at, presence: true
  validate :betting_deadline_at_cannot_be_no_in_date

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
    return if betting_deadline_at&.in?(date.all_day)

    errors.add(:betting_deadline_at, 'must be with in same date  of value of date property')
  end
end
