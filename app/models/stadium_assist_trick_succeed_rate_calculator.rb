class StadiumAssistTrickSucceedRateCalculator
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :stadium_tel_code
  attribute :trick

  validates :stadium_tel_code, presence: true
  validates :trick, presence: true,
                    inclusion: { in: [
                      AssistTrick::Nigashi.instance,
                      AssistTrick::Sasare.instance,
                      AssistTrick::Makurare.instance,
                    ] }

  def calculate!(aggregation_range:, context: {})
    validate!

    Rails.cache.fetch(cache_key(aggregation_range: aggregation_range, context: context), expires_in: 1.hour) do
      races = Race.where(stadium_tel_code: stadium_tel_code).where(date: aggregation_range)
      if context.present?
        wind_velocity = context.fetch(:wind_velocity)
        wind_angle = context.fetch(:wind_angle, nil)
        raise ArgumentError.new("wind angle not specifed") if !wind_velocity.zero? && wind_angle.nil?

        races = races.by_wind_condition_in_performance(wind_velocity: wind_velocity, wind_angle: wind_angle)
      end
      races = races.includes({ race_entries: { race_record: :winning_race_entry } })

      numerator =
        races
        .joins({ race_entries: { race_record: :winning_race_entry } })
        .merge(WinningRaceEntry.where(winning_trick: trick.asist_trick_ids))
        .count

      begin
        # todo: 母数が少なかったら例外発生させたい
        Rational(numerator, races.count).to_f
      rescue ZeroDivisionError
        0
      end
    end
  end

  private

  def cache_key(aggregation_range:, context:)
    [
      self.class.name.underscore,
      Digest::MD5.hexdigest(
        [
          stadium_tel_code,
          trick.id,
          context,
          aggregation_range.first,
          aggregation_range.last,
        ].map(&:to_s).join('-')
      )
    ].join(':')
  end
end
