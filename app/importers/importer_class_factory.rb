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
    else
      raise NotImplementedError
    end
  end
end
