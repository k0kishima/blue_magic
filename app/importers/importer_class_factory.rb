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
    else
      raise NotImplementedError
    end
  end
end
