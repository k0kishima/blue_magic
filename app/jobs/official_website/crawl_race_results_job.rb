module OfficialWebsite
  class CrawlRaceResultsJob < CrawlJob
    def perform(stadium_tel_code:, race_opened_on:, race_number:, version: DEFAULT_VERSION)
      page = OfficialWebsite::RaceResultPage.new(
        version: version, stadium_tel_code: stadium_tel_code,
        race_opened_on: race_opened_on, race_number: race_number, no_cache: no_cache
      )
      crawler = Crawler.new(page)
      crawler.crawl!
    end
  end
end
