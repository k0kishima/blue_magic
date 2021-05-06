# TODO: 名前やクラスの粒度を考え直す
module OfficialWebsite
  class CrawlOpenedOrWillOpenRacesJob < CrawlJob
    include CrawlingPauseable

    SLEEP_SECOND = 1

    def perform(date: Date.today, version: DEFAULT_VERSION)
      raise ArgumentError.new('cannot specify a date which is greater than today') if date > Date.today

      EventHolding.opened_on(date).each do |event_holding|
        Race.numbers.each do |race_number|
          sleep SLEEP_SECOND

          OfficialWebsite::CrawlRaceInformationsJob.perform_later(
            version: version,
            race_opened_on: date, race_number: race_number, stadium_tel_code: event_holding.stadium_tel_code
          )
        end
      end
    end
  end
end
