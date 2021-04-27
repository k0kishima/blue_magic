module OfficialWebsite
  class CrawlBoatSettingsJob < CrawlJob
    def perform(stadium_tel_code:, race_opened_on:, race_number:, version: DEFAULT_VERSION)
      args = {
        version: version, stadium_tel_code: stadium_tel_code,
        race_opened_on: race_opened_on, race_number: race_number, no_cache: no_cache
      }
      race_information_page = OfficialWebsite::RaceInformationPage.new(args)
      race_exhibition_information_page = OfficialWebsite::RaceExhibitionInformationPage.new(args)
      crawler = Crawler.new(race_information_page, race_exhibition_information_page)
      crawler.crawl!
    end
  end
end
