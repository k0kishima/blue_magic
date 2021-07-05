class RaceAnalysisCacheFactory
  class << self
    def create!(stadium_tel_code:, date:, race_number:)
      race =
        Race
        .includes(
          :weather_conditions,
          :odds,
          {
            race_entries: [
              :start_exhibition_record,
              :disqualified_race_entry,
              :racer_winning_rate_aggregation,
              { boat_setting: [:motor_betting_contribute_rate_aggregation, :boat_betting_contribute_rate_aggregation] },
            ]
          }
        ).find_by!(stadium_tel_code: stadium_tel_code, date: date, race_number: race_number)

      begin
        race.stadium.aggregation_offset_date = race.date
        race.stadium.context = race.weather_condition_in_exhibition.slice(:wind_angle, :wind_velocity)

        RankingSetting::RACE_ENTRY.each do |need_to_rank_attribute_name, evaluation_policy|
          RankedAttributeDecorator.bulk_decorate!(
            objects: race.race_entries,
            need_to_rank_attribute_name: need_to_rank_attribute_name,
            evaluation_policy: evaluation_policy
          )
        end

        race_kpis = Kpi.where(entry_object_class_name: 'Race')
        # tryだとmethod_missing でメタプロしたメソッドがコールできないので不本意ながらsendで・・・
        data = race_kpis.map{|kpi| [kpi.attribute_name, race.send(kpi.attribute_name)] }.to_h

        race_entry_kpis = Kpi.where(entry_object_class_name: 'RaceEntry')
        Pit::NUMBER_RANGE.each do |pit_number|
          data["pit_number_#{pit_number}"] = race_entry_kpis.map{|kpi| [kpi.attribute_name, race.try("pit_number_#{pit_number}").try(kpi.attribute_name)] }.to_h
        end

        RaceAnalysisCache.create(stadium_tel_code: stadium_tel_code, date: date, race_number: race_number, data: data)
      rescue => e
        RaceAnalysisCache.create(stadium_tel_code: stadium_tel_code, date: date, race_number: race_number, error_message: e.message)
      end
    end
  end
end
