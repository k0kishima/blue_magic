class ParserClassFactory
  def self.bulk_create!(scraper)
    # TODO: バージョン追加された時点で修正する
    case scraper.class.name
    when 'OfficialWebsite::V1707::EventsScraper'
      [EventListParser]
    when 'OfficialWebsite::V1707::RacerProfilesScraper'
      [RacerListParser]
    when 'OfficialWebsite::V1707::RaceInformationsScraper'
      [RaceListParser]
    when 'OfficialWebsite::V1707::RaceEntriesScraper'
      [RaceEntryListParser, BoatBettingContributeRateAggregationParser, MotorBettingContributeRateAggregationParser,
       RacerWinningRateAggregationParser]
    when 'OfficialWebsite::V1707::RaceExhibitionRecordsScraper'
      [RaceExhibitionRecordsParser]
    when 'OfficialWebsite::V1707::RacerConditionsScraper'
      [RacerConditionListParser]
    when 'OfficialWebsite::V1707::WeatherConditionsScraper'
      [WeatherConditionListParser]
    when 'OfficialWebsite::V1707::RaceRecordsScraper'
      [RaceRecordListParser, DisqualifiedRaceEntryListParser, WinningRaceEntryListParser]
    when 'OfficialWebsite::V1707::PayoffsScraper'
      [PayoffListParser]
    when 'OfficialWebsite::V1707::OddsScraper'
      [OddsListParser]
    else
      raise NotImplementedError
    end
  end
end
