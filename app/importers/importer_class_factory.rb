class ImporterClassFactory
  def self.create!(parser)
    case parser.class.name
    when 'EventListParser'
      EventsImporter
    when 'RacerListParser'
      RacersImporter
    when 'RaceListParser'
      RacesImporter
    when 'RaceEntryListParser'
      RaceEntriesImporter
    when 'BoatBettingContributeRateAggregationParser'
      BoatBettingContributeRateAggregationImporter
    when 'MotorBettingContributeRateAggregationParser'
      MotorBettingContributeRateAggregationImporter
    when 'RacerWinningRateAggregationParser'
      RacerWinningRateAggregationImporter
    when 'RaceExhibitionRecordsParser'
      RaceExhibitionRecordsImporter
    when 'RacerConditionListParser'
      RacerConditionsImporter
    when 'WeatherConditionListParser'
      WeatherConditionsImporter
    when 'RaceRecordListParser'
      RaceRecordsImporter
    when 'DisqualifiedRaceEntryListParser'
      DisqualifiedRaceEntriesImporter
    when 'WinningRaceEntryListParser'
      WinningRaceEntriesImporter
    when 'PayoffListParser'
      PayoffsImporter
    when 'OddsListParser'
      OddsImporter
    when 'BoatSettingListParser'
      BoatSettingsImporter
    when 'MotorMaintenanceListParser'
      MotorMaintenancesImporter
    else
      raise NotImplementedError
    end
  end
end
