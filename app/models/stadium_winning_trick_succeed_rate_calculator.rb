class StadiumWinningTrickSucceedRateCalculator
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :stadium_tel_code
  attribute :trick
  attribute :course_number

  validates :stadium_tel_code, presence: true
  validates :course_number, presence: true
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

    races = Race.where(stadium_tel_code: stadium_tel_code).where(date: aggregation_range)

    if context.present?
      wind_velocity = context.fetch(:wind_velocity)
      wind_angle = context.fetch(:wind_angle, nil)
      raise ArgumentError.new("wind angle not specifed") if !wind_velocity.zero? && wind_angle.nil?

      races =
        races
        .joins(:weather_conditions)
        .merge(
          WeatherCondition
            .where(in_performance: true)
            .where(wind_velocity: wind_velocity, wind_angle: wind_angle)
        )
    end

    races = races.includes({ race_entries: { race_record: :winning_race_entry } })

    numerator = races.select do |race|
      winner = race.winner
      winner.present? && winner.winning_trick_id == trick.id && winner.race_record.course_number == course_number
    end.count

    begin
      Rational(numerator, races.count)
    rescue ZeroDivisionError
      0
    end
  end

  private

  def course_number_must_be_avairable_at_trick
    return if course_number.blank? || trick.blank?
    return if course_number.in?(trick.available_course_numbers)

    errors.add(:course_number, "course number must be avairable at the #{trick.class.name}")
  end
end
