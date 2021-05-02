class ImportDataQueueFactory
  def self.create!(scraper_class, *pages)
    raise ArgumentError.new('there is difference between page types') unless pages.map(&:class).same?

    data = []
    pages.each do |page|
      begin
        data << scraper_class.new(file: page.file).scrape!
      rescue DataNotFound
        Rails.logger.debug("this race has been skipped because data not found (url: #{page.origin_redirection_url})")
      rescue RaceCanceled
        Rails.logger.debug("this race has been canceled because data not found (url: #{page.origin_redirection_url})")
      rescue StandardError => e
        slack_client ||= Slack::Web::Client.new
        slack_client.chat_postMessage(channel: '001_crawler_emergency',
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
