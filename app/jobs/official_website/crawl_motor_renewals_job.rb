module OfficialWebsite
  class CrawlMotorRenewalsJob < CrawlJob
    include CrawlingPauseable

    discard_on ActiveRecord::RecordNotUnique

    def perform(date: Date.today, version: DEFAULT_VERSION)
      raise ArgumentError.new('cannot specify a date which is greater than today') if date > Date.today

      scraper_class = OfficialWebsite::ScraperClassFactory.create!('event_entry', version: version)

      event_holdings = EventHolding.opened_on(date).select(&:is_first_day)
      event_holdings.each do |event_holding|
        page = OfficialWebsite::EventEntriesPage.new(
          version: version,
          stadium_tel_code: event_holding.stadium_tel_code, event_starts_on: date,
        )
        page.reload! if need_to_realod?
        begin
          data = scraper_class.new(file: page.file).scrape!
          if data.all? { |attributes| attributes.fetch(:quinella_rate_of_motor).zero? }
            MotorRenewal.create!(stadium_tel_code: event_holding.stadium_tel_code, date: date)
          end
        rescue ::DataNotFound
          # NOTE: このバージョンの公式サイトの仕様だと中止になった節でも前検の前にアクセスした場合でもコンテンツが同じで判別できない
          next
        end
      end
    end
  end
end
