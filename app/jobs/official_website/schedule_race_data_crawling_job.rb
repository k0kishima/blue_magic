module OfficialWebsite
  class ScheduleRaceDataCrawlingJob < CrawlJob
    # NOTE: レースの基本情報も再取得されるが、投票締め切り時刻が変わったり中止になったりすることはあるので問題ない
    CRAWL_RACE_DATA_JOBS = [
      CrawlRaceInformationsJob,
      CrawlRaceExhibitionInformationsJob,
      CrawlRaceResultsJob,
      CrawlOddsJob,
      CrawlBoatSettingsJob,
    ]

    def perform(date: Date.today, version: DEFAULT_VERSION)
      raise ArgumentError.new('cannot specify a date which is greater than today') if date > Date.today

      # NOTE: 締め切り時刻を基準にクロールするので、そのデータが先に存在している必要がある
      # この時間的序列が生じるのは止むを得ないか・・・
      races = Race.where(date: date)
      raise ArgumentError.new('races not found in specified date') if races.blank?

      races.each do |race|
        CRAWL_RACE_DATA_JOBS.each do |crawl_data_job|
          crawl_data_job
            .set(wait_until: race.betting_deadline_at - 10.minutes)
            .perform_later(
              stadium_tel_code: race.stadium_tel_code,
              race_opened_on: race.date,
              race_number: race.race_number,
              version: version
            )
        end
      end
    end
  end
end
