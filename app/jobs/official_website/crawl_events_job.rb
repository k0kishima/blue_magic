module OfficialWebsite
  class CrawlEventsJob < CrawlJob
    def perform(year:, month:, version: DEFAULT_VERSION)
      page = OfficialWebsite::EventSchedulePage.new(version: version, year: year, month: month, no_cache: no_cache)
      crawler = Crawler.new(page)
      crawler.crawl!
    end
  end
end
