class RacerWinningTrickSucceedRateCalculator
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :racer_registration_number
  attribute :trick
  attribute :course_number

  validates :racer_registration_number, presence: true
  validates :course_number, presence: true
  validates :trick, presence: true,
                    inclusion: { in: [
                      WinningTrick::Nige.instance,
                      WinningTrick::Sashi.instance,
                      WinningTrick::Makuri.instance,
                      WinningTrick::Makurizashi.instance,
                    ] }
  validate :course_number_must_be_avairable_at_trick

  def calculate!(aggregation_range:)
    validate!

    race_records =
      RaceRecord
      .joins(:race_entry)
      .where(course_number: course_number)
      .where(date: aggregation_range)
      .merge(RaceEntry.where(racer_registration_number: racer_registration_number))

    won_by_specified_trick_races =
      race_records
      .joins(:winning_race_entry)
      .merge(WinningRaceEntry.where(winning_trick: trick.id))

    begin
      Rational(won_by_specified_trick_races.count, race_records.count).to_f
    rescue ZeroDivisionError
      0
    end
  end

  private

  def course_number_must_be_avairable_at_trick
    return if course_number.blank? || trick.blank?
    return if course_number.in?(trick.available_course_numbers)

    errors.add(:course_number, "#{course_number} cannot calculate at the #{trick.class.name}")
  end
end
