class ImportDataQueueFactory
  def self.create!(scraper_class, *pages)
    raise ArgumentError.new('there is difference between page types') unless pages.map(&:class).same?

    data = []
    pages.each do |page|
      begin
        data << scraper_class.new(file: page.file).scrape!
      rescue StandardError => e
        Rails.logger.debug("scpaping error: #{e.message} (url: #{page.origin_redirection_url})")
      ensure
        page.file.close
      end
    end

    csv = CsvFactory.create!(data.flatten)
    begin
      ImportDataQueue.waiting_to_start.create!(file: csv)
    ensure
      csv.close
    end
  end
end
