class ScraperClassFactory
  def self.bulk_create!(page)
    # TODO: バージョン追加された時点で修正する
    case page.class.name
    when 'OfficialWebsite::EventSchedulePage'
      [OfficialWebsite::V1707::EventsScraper]
    when 'OfficialWebsite::RacerProfilePage'
      [OfficialWebsite::V1707::RacerProfilesScraper]
    when 'OfficialWebsite::EventHoldingsPage'
      [OfficialWebsite::V1707::EventHoldingsScraper]
    when 'OfficialWebsite::EventEntriesPage'
      [OfficialWebsite::V1707::EventEntriesScraper]
    when 'OfficialWebsite::RaceInformationPage'
      [OfficialWebsite::V1707::RaceInformationsScraper, OfficialWebsite::V1707::RaceEntriesScraper]
    when 'OfficialWebsite::RaceExhibitionInformationPage'
      [OfficialWebsite::V1707::RaceExhibitionRecordsScraper, OfficialWebsite::V1707::RacerConditionsScraper,
       OfficialWebsite::V1707::BoatSettingsScraper, OfficialWebsite::V1707::MotorMaintenancesScraper,
       OfficialWebsite::V1707::WeatherConditionsScraper]
    when 'OfficialWebsite::RaceResultPage'
      [OfficialWebsite::V1707::RaceRecordsScraper, OfficialWebsite::V1707::PayoffsScraper]
    when 'OfficialWebsite::RaceOddsPage'
      [OfficialWebsite::V1707::OddsScraper]
    else
      raise NotImplementedError
    end
  end
end
