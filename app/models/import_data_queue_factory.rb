class ImportDataQueueFactory
  def self.create!(scraper_class, *pages)
    raise ArgumentError.new('there is difference between page types') unless pages.map(&:class).same?

    slack_client = Slack::Web::Client.new

    data = []
    pages.each do |page|
      begin
        data << scraper_class.new(file: page.file).scrape!
      rescue DataNotFound
        unless page.no_cache
          page.no_cache = true
          retry
        else
          slack_client
            .chat_postMessage(channel: '001_crawler_emergency',
                              text: "need to confirm that it's error or not. (url: #{page.origin_redirection_url})")
        end
      rescue RaceCanceled
        CancelRaceJob.perform_later(stadium_tel_code: page.stadium_tel_code, date: page.race_opened_on,
                                    race_number: page.race_number)
      rescue StandardError => e
        slack_client
          .chat_postMessage(channel: '001_crawler_emergency',
                            text: "#{e.message} (url: #{page.origin_redirection_url})")
      ensure
        page.file.close
      end
    end

    csv = CsvFactory.create!(data.flatten)
    begin
      ImportDataQueue.create!(file: csv)
    ensure
      csv.close
    end
  end
end
