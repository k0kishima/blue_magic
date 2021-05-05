# TODO: 名前やクラスの粒度を考え直す
module OfficialWebsite
  class CrawlOpenedOrWillOpenRacesJob < CrawlJob
    include CrawlingPauseable

    SLEEP_SECOND = 1

    def perform(date: Date.today, version: DEFAULT_VERSION)
      raise ArgumentError.new('cannot specify a date which is greater than today') if date > Date.today

      event_holdings = EventHolding.opened_on(date)
      pages = event_holdings.map do |event_holding|
        Race.numbers.map do |race_number|
          sleep SLEEP_SECOND

          OfficialWebsite::RaceInformationPage.new(
            version: version, no_cache: no_cache,
            race_opened_on: date, race_number: race_number, stadium_tel_code: event_holding.stadium_tel_code
          )
        end
      end.flatten

      scraper_class = OfficialWebsite::ScraperClassFactory.create!('race_information')
      ImportDataQueueFactory.create!(scraper_class, *pages)
    end
  end
end
