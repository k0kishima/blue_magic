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

  scope :not_canceled, -> { where(canceled: false) }

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
               .where(starts_on: (date - 1.week)..date)
               .last
  end

  def weather_condition_in_performance
    weather_conditions.find { |weather_condition| weather_condition.in_performance }
  end

  def weather_condition_in_exhibition
    weather_conditions.find { |weather_condition| !weather_condition.in_performance }
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

  def is_special_race
    title&.include?('特')
  end

  def is_selection_race
    title&.include?('選抜')
  end

  def is_semifinal
    # NOTE: ナイターは9〜11Rが準優で、12Rが一般戦の場合がある
    return false if race_number < 9

    title&.match?(/\A準優/)
  end

  def is_final
    return false unless race_number == 12

    title&.match?(/\A優勝/)
  end

  def absent_race_entries_count
    @absent_race_entries_count ||= race_entries.absent.count
  end

  Pit::NUMBER_RANGE.each do |pit_number|
    class_eval %Q{
      def pit_number_#{pit_number} = race_entries.find{|re| re.pit_number == #{pit_number} }
    }
  end

  # current というのは何に対して current かというとレシーバであるraceオブジェクトの日付を基準にしたときの今期なわけだが
  # もう少しいい命名はないか模索したい
  def current_racer_rating_evaluation_term
    @current_racer_rating_evaluation_term ||= RacerRatingEvaluationTerm.initialize_by(date: date)
  end

  # NOTE: 集計時に現在のレース(集計の起点となるレース)結果を含めてしまわないように注意
  #
  # 例えば以下のレース
  # http://boatrace.jp/owpc/pc/race/racelist?rno=3&jcd=16&hd=20181216
  #
  # 4220 深川 はこのレースでフライングをした
  # このレース開始時点ではまだF1なので, このレース後にF2になるのが正しい
  # しかし、これを日付で取ってしまうとこのレースでのフライングも含まれてしまい、レース開始前にF2だと判定されてしまう
  #
  # したがって、レースの発売締め切り時刻(datetime)の精度で選択しないと意図しない失格判定がされてしまい、
  # 予想に支障をきたすため締め切り時刻を基準とすること(尚且つ集計の起点となるレースは「含めない」)
  def range_for_current_racer_rating_evaluation_term_aggregation
    @range_for_current_racer_rating_evaluation_term_aggregation ||= \
      current_racer_rating_evaluation_term.starts_on.in_time_zone...betting_deadline_at
  end

  def range_for_current_series_aggregation
    @range_for_current_series_aggregation ||= -> do
      raise DataNotPrepared if event.blank?

      event.starts_on.in_time_zone...betting_deadline_at
    end.call
  end

  def winning_rate_in_all_stadium_mean
    race_entries.map(&:winning_rate_in_all_stadium).mean
  end

  def winning_rate_in_all_stadium_sd
    race_entries.map(&:winning_rate_in_all_stadium).sd
  end

  def motor_quinella_rate_mean
    race_entries.map(&:motor_quinella_rate).mean
  end

  def motor_quinella_rate_sd
    race_entries.map(&:motor_quinella_rate).sd
  end

  def wind_velocity_when_exhibition
    weather_condition_in_exhibition.wind_velocity
  end

  private

  def betting_deadline_at_cannot_be_no_in_date
    return if date&.all_day&.cover?(betting_deadline_at)

    errors.add(:betting_deadline_at, 'must be with in same date  of value of date property')
  end

  def method_missing(method_name, *)
    decomposed_method_name = method_name.to_s.split('_')
    suffix = decomposed_method_name.pop
    attribute = decomposed_method_name.join('_')

    rankable_attributes = RankingSetting::RACE_ENTRY.keys.map(&:to_s)
    if attribute.in?(rankable_attributes) && suffix.in?(%w[first second third fourth fifth sixth])
      raise ::DataNotFound, 'fetch race entry data before calculate ranking attributes' if race_entries.blank?

      samples = race_entries.map { |race_entry| race_entry.try(attribute) }
      sorted_samples = samples.sort

      evaluation_policy = RankingSetting::RACE_ENTRY.symbolize_keys.fetch(attribute.to_sym)
      sorted_samples = sorted_samples.reverse if evaluation_policy == :bigger_is_better

      sorted_samples.try(suffix)
    else
      super
    end
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
