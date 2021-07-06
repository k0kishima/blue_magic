class StadiumWinningTrickSucceedRateCalculator
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :stadium_tel_code
  attribute :trick
  attribute :course_number

  validates :stadium_tel_code, presence: true
  validates :trick, presence: true,
                    inclusion: { in: [
                      WinningTrick::Nige.instance,
                      WinningTrick::Sashi.instance,
                      WinningTrick::Makuri.instance,
                      WinningTrick::Makurizashi.instance,
                    ] }
  validate :course_number_must_be_avairable_at_trick

  def calculate!(aggregation_range:, context:)
    validate!

    Rails.cache.fetch(cache_key(aggregation_range: aggregation_range, context: context), expires_in: 1.hour) do
      races = Race.where(stadium_tel_code: stadium_tel_code).where(date: aggregation_range)

      if context.present?
        wind_velocity = context.fetch(:wind_velocity)
        wind_angle = context.fetch(:wind_angle, nil)
        raise ArgumentError.new("wind angle not specifed") if !wind_velocity.zero? && wind_angle.nil?

        races = races.by_wind_condition_in_performance(wind_velocity: wind_velocity, wind_angle: wind_angle)
      end

      races = races
              .includes({ race_entries: { race_record: :winning_race_entry } })

      won_by_specified_trick_races =
        races
        .joins({ race_entries: { race_record: :winning_race_entry } })
        .merge(WinningRaceEntry.where(winning_trick: trick.id))

      if course_number.present?
        won_by_specified_trick_races =
          won_by_specified_trick_races.merge(RaceRecord.where(course_number: course_number))
      end

      begin
        Rational(won_by_specified_trick_races.count, races.count).to_f
      rescue ZeroDivisionError
        0
      end
    end
  end

  private

  def course_number_must_be_avairable_at_trick
    return if course_number.blank? || trick.blank?
    return if course_number.in?(trick.available_course_numbers)

    errors.add(:course_number, "#{course_number} cannot calculate at the #{trick.class.name}")
  end

  def cache_key(aggregation_range:, context:)
    [
      self.class.name.underscore,
      Digest::MD5.hexdigest(
        [
          stadium_tel_code,
          trick.id,
          course_number,
          context,
          aggregation_range.first,
          aggregation_range.last,
        ].map(&:to_s).join('-')
      )
    ].join(':')
  end
end
