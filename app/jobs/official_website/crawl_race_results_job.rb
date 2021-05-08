module OfficialWebsite
  class CrawlRaceResultsJob < CrawlJob
    def perform(stadium_tel_code:, race_opened_on:, race_number:, version: DEFAULT_VERSION)
      page = OfficialWebsite::RaceResultPage.new(
        version: version, stadium_tel_code: stadium_tel_code,
        race_opened_on: race_opened_on, race_number: race_number
      )
      page.reload! if need_to_realod?
      crawler = Crawler.new(page)
      crawler.crawl!
    rescue ::RaceCanceled
      CancelRaceJob.perform_later(stadium_tel_code: stadium_tel_code, race_opened_on: race_opened_on,
                                  race_number: race_number)
    rescue ::DataNotFound
      raise if race_opened_on >= Date.today
    end
  end
end
