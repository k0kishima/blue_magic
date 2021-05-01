module OfficialWebsite
  class CrawlOddsJob < CrawlJob
    def perform(stadium_tel_code:, race_opened_on:, race_number:, version: DEFAULT_VERSION)
      page = OfficialWebsite::RaceOddsPage.new(
        version: version, stadium_tel_code: stadium_tel_code,
        race_opened_on: race_opened_on, race_number: race_number, no_cache: no_cache
      )
      crawler = Crawler.new(page)
      crawler.crawl!
    rescue ::RaceCanceled
      race = Race.find_by(stadium_tel_code: stadium_tel_code, date: race_opened_on, race_number: race_number)
      race.update!(canceled: true) if race.present?
    end
  end
end
