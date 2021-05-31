class RacerWinningTrickKpi < Kpi
  AGGREGATION_YEARS = 1

  def value!
    validate!(:calculation)
    check_data_preparation!

    calculator = RacerWinningTrickSucceedRateCalculator.new(
      trick: trick,
      racer_registration_number: entry_object.racer_registration_number,
      course_number: entry_object.course_number_in_exhibition,
    )
    calculator.calculate!(aggregation_range: aggregation_starts_on..aggregation_ends_on)
  end

  private

  def trick
    @trick ||= case attribute_name
               when /nige_succeed_rate/
                 WinningTrick::Nige.instance
               when /sashi_succeed_rate/
                 WinningTrick::Sashi.instance
               when /makuri_succeed_rate/
                 WinningTrick::Makuri.instance
               when /makurizashi_succeed_rate/
                 WinningTrick::Makurizashi.instance
               else
                 raise StandardError, "cannot assign a winning trick to key: #{attribute_name}"
               end
  end

  def offset_date
    entry_object.race.date
  end

  def aggregation_starts_on
    (offset_date - AGGREGATION_YEARS.years).prev_month.beginning_of_month
  end

  def aggregation_ends_on
    offset_date.prev_month.end_of_month
  end

  def check_data_preparation!
    return if entry_object.course_number_in_exhibition.present?

    raise DataNotPrepared, 'the source object does not have exhibition data yet'
  end
end

# == Schema Information
#
# Table name: kpis
#
#  id                                                                                                                                                                                      :bigint           not null, primary key
#  type                                                                                                                                                                                    :string(255)      not null
#  entry_object_class_name(値の算出をするために利用するオブジェクトのことをentry object と定義し、そのクラス名をここで指定（webpackのエントリーポイントとのアナロジーからこのように命名）) :string(255)      not null
#  name                                                                                                                                                                                    :string(255)      not null
#  description                                                                                                                                                                             :text(65535)
#  attribute_name                                                                                                                                                                          :string(255)      not null
#  created_at                                                                                                                                                                              :datetime         not null
#  updated_at                                                                                                                                                                              :datetime         not null
#
# Indexes
#
#  index_kpis_on_entry_object_class_name_and_attribute_name  (entry_object_class_name,attribute_name) UNIQUE
#
