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
      .includes(:winning_race_entry)

    numerator = race_records.select { |race_record| race_record.winning_trick_id == trick.id }.count

    begin
      Rational(numerator, race_records.count)
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
