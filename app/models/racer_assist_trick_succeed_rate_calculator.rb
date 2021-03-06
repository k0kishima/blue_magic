class RacerAssistTrickSucceedRateCalculator
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :racer_registration_number
  attribute :trick
  attribute :course_number

  validates :racer_registration_number, presence: true
  validates :course_number, presence: true
  validates :trick, presence: true,
                    inclusion: { in: [
                      AssistTrick::Nigashi.instance,
                      AssistTrick::Sasare.instance,
                      AssistTrick::Makurare.instance,
                    ] }
  validate :course_number_must_be_avairable_at_trick

  def calculate!(aggregation_range:)
    validate!

    Rails.cache.fetch(cache_key(aggregation_range), expires_in: 1.hour) do
      races =
        Race
        .joins({ race_entries: :race_record })
        .where(date: aggregation_range)
        .merge(
          RaceRecord
          .where(course_number: course_number)
          .merge(RaceEntry.where(racer_registration_number: racer_registration_number))
        )
        .includes({ race_entries: { race_record: :winning_race_entry } })

      numerator = races.select do |race|
        race.winner.present? && race.winner.winning_trick_id.in?(trick.asist_trick_ids)
      end.count

      begin
        Rational(numerator, races.count).to_f
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

  def cache_key(aggregation_range)
    [
      self.class.name.underscore,
      Digest::MD5.hexdigest(
        [
          racer_registration_number,
          trick.id,
          course_number,
          aggregation_range.first,
          aggregation_range.last,
        ].map(&:to_s).join('-')
      )
    ].join(':')
  end
end
