module OfficialWebsite
  class CrawlRacerProfilesJob < CrawlJob
    def perform(racer_registration_number:, version: DEFAULT_VERSION)
      page = OfficialWebsite::RacerProfilePage.new(version: version,
                                                   racer_registration_number: racer_registration_number)
      page.reload! if need_to_realod?
      crawler = Crawler.new(page)
      crawler.crawl!
    end
  end
end
