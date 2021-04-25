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
       OfficialWebsite::V1707::WeatherConditionsScraper]
      # TODO: 以下を対応する
      # OfficialWebsite::V1707::BoatSettingsScraper, OfficialWebsite::V1707::MotorMaintenancesScraper,
    when 'OfficialWebsite::RaceResultPage'
      # NOTE: 気象情報は展示と本番それぞれで取る
      [OfficialWebsite::V1707::WeatherConditionsScraper, OfficialWebsite::V1707::RaceRecordsScraper,
       OfficialWebsite::V1707::PayoffsScraper]
    when 'OfficialWebsite::RaceOddsPage'
      [OfficialWebsite::V1707::OddsScraper]
    else
      raise NotImplementedError
    end
  end
end
