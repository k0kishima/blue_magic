module OfficialWebsite
  class CrawlBoatSettingsJob < CrawlJob
    # HACK: 本来このエラーは捨てていいのだが、このジョブだとCSV生成時の配列の構造が不正でも上がってくる
    # そのケースでリトライしたら成功することがあるので一応再実行制御を入れている
    # TODO: 正式に調査する
    retry_on ArgumentError, wait: 1.minutes, attempts: 3 do |job, errror|
      message = {
        error_message: error.message,
        job_name: job.class.name,
        arguments: job.arguments.to_s,
      }.map { |key, value| [key, value].join(': ') }.join("\n")
      job.notify_error(message)
    end

    def perform(stadium_tel_code:, race_opened_on:, race_number:, version: DEFAULT_VERSION)
      args = {
        version: version, stadium_tel_code: stadium_tel_code,
        race_opened_on: race_opened_on, race_number: race_number, no_cache: no_cache
      }
      race_information_page = OfficialWebsite::RaceInformationPage.new(args)
      race_exhibition_information_page = OfficialWebsite::RaceExhibitionInformationPage.new(args)
      crawler = Crawler.new(race_information_page, race_exhibition_information_page)
      crawler.crawl!
    rescue ::DataNotFound
      raise if race_opened_on >= Date.today
    end
  end
end
