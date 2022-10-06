module OfficialWebsite
  class ScheduleRaceDataCrawlingJob < CrawlJob
    include CrawlingPauseable

    def perform(date: Date.today, version: DEFAULT_VERSION)
      raise ArgumentError.new('cannot specify a date which is greater than today') if date > Date.today

      # NOTE: 締め切り時刻を基準にクロールするので、そのデータが先に存在している必要がある
      # この時間的序列が生じるのは止むを得ないか・・・
      races = Race.where(date: date)
      raise ArgumentError.new('races not found in specified date') if races.blank?

      races.each do |race|
        # NOTE: レースの基本情報も再取得されるが、投票締め切り時刻が変わったり中止になったりすることはあるので問題ない
        [
          CrawlRaceInformationsJob,
          CrawlRaceExhibitionInformationsJob,
          CrawlBoatSettingsJob,
        ].each do |crawl_data_job|
          crawl_data_job
            .set(wait_until: race.betting_deadline_at - 10.minutes)
            .perform_later(
              stadium_tel_code: race.stadium_tel_code,
              race_opened_on: race.date,
              race_number: race.race_number,
              version: version
            )
        end

        # TODO: 以下は後でちゃんとまとめる
        CrawlOddsJob
          .set(wait_until: race.betting_deadline_at - 5.minutes)
          .perform_later(
            stadium_tel_code: race.stadium_tel_code,
            race_opened_on: race.date,
            race_number: race.race_number,
            version: version
          )

        # TODO: クロールに関するジョブじゃないのでここでスケジューリングしない
        if race.date == Time.zone.today && Forecaster.current.present?
          BetJob
            .set(wait_until: race.betting_deadline_at - 3.minutes)
            .perform_later(
              forecaster_id: Forecaster.current.id,
              stadium_tel_code: race.stadium_tel_code,
              race_opened_on: race.date,
              race_number: race.race_number,
            )
        end

        # note: 今は結果をタイムラグ小さく取るよりも確実に取りたいので間隔は結構空けてる
        CrawlRaceResultsJob
          .set(wait_until: race.betting_deadline_at + 15.minutes)
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
