class RaceEntry < ApplicationRecord
  include RaceAssociating

  self.primary_keys = [:stadium_tel_code, :date, :race_number, :pit_number]

  scope :absent, -> {
    joins(:disqualified_race_entry)
      .merge(DisqualifiedRaceEntry.where(disqualification: Disqualification::ID::ABSENT))
  }
  scope :not_absent, -> {
    left_joins(:disqualified_race_entry)
      .where(disqualified_race_entries: { disqualification: [nil, *Disqualification.cannnot_pre_fetchable_ids] })
  }

  has_one :start_exhibition_record, foreign_key: self.primary_keys
  has_one :circumference_exhibition_record, foreign_key: self.primary_keys
  has_one :race_record, foreign_key: self.primary_keys
  has_one :boat_setting, foreign_key: self.primary_keys
  has_one :disqualified_race_entry, foreign_key: self.primary_keys
  has_one :racer_winning_rate_aggregation, foreign_key: [:racer_registration_number, :aggregated_on],
                                           primary_key: [:racer_registration_number, :date]

  belongs_to :racer, foreign_key: :racer_registration_number, optional: true
  belongs_to :race, foreign_key: [:stadium_tel_code, :date, :race_number], optional: true

  validates :pit_number, presence: true, inclusion: { in: Pit::NUMBER_RANGE }
  validates :racer_registration_number, presence: true

  delegate :motor_number, :motor_quinella_rate, :motor_trio_rate, :boat_number, :boat_quinella_rate, :boat_trio_rate,
           to: :boat_setting
  delegate :exhibition_time, :exhibition_time_order, to: :circumference_exhibition_record
  delegate :event, to: :race

  attribute :motor_quinella_rate, :float
  attribute :motor_trio_rate, :float

  def absent?
    disqualified_race_entry.present? && disqualified_race_entry.disqualification == Disqualification::ID::ABSENT
  end

  def course_number_in_exhibition
    start_exhibition_record&.course_number
  end

  def start_time_in_exhibition
    start_exhibition_record&.start_time
  end

  def winning_rate_in_all_stadium
    racer_winning_rate_aggregation&.rate_in_all_stadium
  end

  def winning_rate_in_event_going_stadium
    racer_winning_rate_aggregation&.rate_in_event_going_stadium
  end

  # 集計対象が全場なので接尾辞に _in_all_stadium などつけた方がいいと考えたが、
  # そもそも特定場の集計することがないので n着率 に関しては全場対象を暗黙の了解とする
  # 場の得手不得手は当地勝率で判断できる。コースに関しても同様
  def first_place_rate_on_start_course_in_exhibition
    Rational(counts_indexed_by_order_of_arrival.fetch(1, 0), counts_indexed_by_order_of_arrival.values.sum || 0).to_f
  end

  def second_place_rate_on_start_course_in_exhibition
    Rational(counts_indexed_by_order_of_arrival.fetch(2, 0), counts_indexed_by_order_of_arrival.values.sum || 0).to_f
  end

  def third_place_rate_on_start_course_in_exhibition
    Rational(counts_indexed_by_order_of_arrival.fetch(3, 0), counts_indexed_by_order_of_arrival.values.sum || 0).to_f
  end

  def quinella_rate_on_start_course_in_exhibition
    Rational(
      (
        counts_indexed_by_order_of_arrival.fetch(1, 0) +
        counts_indexed_by_order_of_arrival.fetch(2, 0)
      ),
      counts_indexed_by_order_of_arrival.values.sum || 0
    ).to_f
  end

  def trio_rate_on_start_course_in_exhibition
    Rational(
      (
        counts_indexed_by_order_of_arrival.fetch(1, 0) +
        counts_indexed_by_order_of_arrival.fetch(2, 0) +
        counts_indexed_by_order_of_arrival.fetch(3, 0)),
      counts_indexed_by_order_of_arrival.values.sum || 0
    ).to_f
  end

  # TODO: これ以降のpublic methods はKPIモデルに移行する（プリミティブなKPIの組み合わせなので、エンドユーザーが自由に定義できるといい）
  # FIXME: RankedAttributeDecoratorによる ranked_attributes の動的追加を行った後じゃないとエラーになるバギーなコード
  def performance_score
    ranked_attribute_name = %w(exhibition_time_order motor_quinella_rate_rank winning_rate_in_all_stadium_rank)
    score = 7 * ranked_attribute_name.count

    ranked_attribute_name.each do |kpi|
      value = try(kpi)
      if value.present?
        score -= value
      else
        raise DataNotFound, "raked data (#{ranked_attribute_name}) not found at racer id: #{racer_registration_number}"
      end
    end

    score
  end

  def base_point_as_first
    first_place_rate_on_start_course_in_exhibition * 10 + performance_score
  end

  def base_point_as_second
    quinella_rate_on_start_course_in_exhibition * 7.5 + performance_score
  end

  def base_point_as_third
    trio_rate_on_start_course_in_exhibition * 5 + performance_score
  end

  def order_sum
    motor_quinella_rate_rank + exhibition_time_order + winning_rate_in_all_stadium_rank
  end

  def start_time_average_in_current_series
    current_series_race_records.map(&:start_time).mean
  end

  def start_time_stdev_in_current_series
    current_series_race_records.map(&:start_time).sd
  end

  def start_order_average_in_current_series
    current_series_race_records.map(&:start_order).mean
  end

  def start_order_stdev_in_current_series
    current_series_race_records.map(&:start_order).sd
  end

  def start_time_average_in_current_rating_term
    current_rating_term_race_records.map(&:start_time).mean
  end

  def start_time_stdev_in_current_rating_term
    current_rating_term_race_records.map(&:start_time).sd
  end

  def start_order_average_in_current_rating_term
    current_rating_term_race_records.map(&:start_order).mean
  end

  def start_order_stdev_in_current_rating_term
    current_rating_term_race_records.map(&:start_order).sd
  end

  def order_of_arrivals_in_current_series_without_unfinished
    @order_of_arrivals_in_current_series_without_unfinished ||= \
      current_series_race_records
      .group(:arrival).count
      .reject { |order_of_arrival, _| order_of_arrival.nil? }
      .map { |order_of_arrival, quantity| Array.new(quantity, order_of_arrival) }
      .flatten
  end

  def finished_count_in_current_series
    order_of_arrivals_in_current_series_without_unfinished.count
  end

  def order_of_arrival_average_in_current_series
    order_of_arrivals_in_current_series_without_unfinished.mean
  end

  def order_of_arrival_stdev_in_current_series
    order_of_arrivals_in_current_series_without_unfinished.sd
  end

  private

  def yearly_aggregation_range
    @yearly_aggregation_range ||= AggregationRangeFactory.create_to_aggregate_racer_data_from(date)
  end

  def aggregation_target_race_records
    @aggregation_target_race_records ||= -> do
      raise DataNotPrepared, 'the source object does not have exhibition data yet' if course_number_in_exhibition.blank?

      RaceRecord
        .where(date: yearly_aggregation_range)
        .where(course_number: course_number_in_exhibition)
        .joins(:race_entry)
        .merge(RaceEntry.where(racer_registration_number: racer_registration_number))
    end.call
  end

  def counts_indexed_by_order_of_arrival
    @counts_indexed_by_order_of_arrival ||= aggregation_target_race_records.group(:arrival).count
  end

  def current_series_race_records
    @current_series_race_records ||= \
      RaceRecord
      .joins(race_entry: :race)
      .merge(RaceEntry.where(racer_registration_number: racer_registration_number))
      .merge(Race.where(betting_deadline_at: race.range_for_current_series_aggregation))
  end

  def current_rating_term_race_records
    @current_rating_term_race_records ||= \
      RaceRecord
      .joins(race_entry: :race)
      .merge(RaceEntry.where(racer_registration_number: racer_registration_number))
      .merge(Race.where(betting_deadline_at: race.range_for_current_racer_rating_evaluation_term_aggregation))
  end
end

# == Schema Information
#
# Table name: race_entries
#
#  stadium_tel_code          :integer          not null, primary key
#  date                      :date             not null, primary key
#  race_number               :integer          not null, primary key
#  racer_registration_number :integer          not null
#  pit_number                :integer          not null, primary key
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  uniq_index_1  (stadium_tel_code,date,race_number,racer_registration_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (stadium_tel_code => stadiums.tel_code)
#
