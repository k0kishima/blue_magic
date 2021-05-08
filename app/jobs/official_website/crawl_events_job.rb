module OfficialWebsite
  class CrawlEventsJob < CrawlJob
    include CrawlingPauseable

    def perform(year: Date.today.year, month: Date.today.month, version: DEFAULT_VERSION)
      page = OfficialWebsite::EventSchedulePage.new(version: version, year: year, month: month)
      page.reload! if need_to_realod?
      crawler = Crawler.new(page)
      crawler.crawl!
    end
  end
end
