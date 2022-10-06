module OfficialWebsite
  class CrawlRaceInformationsJob < CrawlJob
    queue_as :critical

    def perform(stadium_tel_code:, race_opened_on:, race_number:, version: DEFAULT_VERSION)
      page = OfficialWebsite::RaceInformationPage.new(
        version: version, stadium_tel_code: stadium_tel_code,
        race_opened_on: race_opened_on, race_number: race_number
      )

      # hack:
      # CrawlOpenedOrWillOpenRacesJob で朝にレースを収集した時のキャッシュが残っている
      # そのキャッシュを利用してスクレイピングすると本番直前に更新された情報が取れない（安定板の着用や周回短縮など）
      # 本来であれば引数などでリロードフラグ渡すなどしてここで判定のロジックを持たないのが好ましいが、一時的にこれで対応
      page.reload! if need_to_realod? || race_opened_on == Date.today
      crawler = Crawler.new(page)
      crawler.crawl!
    rescue ::DataNotFound
      raise if race_opened_on >= Date.today
    end
  end
end
