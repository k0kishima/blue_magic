class CrawlSinglePageToManyScpaerStrategy
  include CrawlingNotifiable

  def initialize(source_page)
    @source_page = source_page
  end

  def crawl!
    available_scraper_classes = ScraperClassFactory.bulk_create!(source_page, context: :single_page)
    available_scraper_classes.each do |scraper_class|
      scraper = scraper_class.new(file: source_page.file)

      data = scraper.scrape!
      if data.blank?
        notify_information("This page have been skipped because data not exist #{source_page.origin_redirection_url}")
        next
      end

      csv = CsvFactory.create!(data)
      begin
        applicable_parser_classes = ParserClassFactory.bulk_create(csv)
        applicable_parser_classes.each do |parser_class|
          parser = parser_class.new(csv)
          available_importer_class = ImporterClassFactory.create!(parser)
          available_importer_class.new.import!(parser.parse!)
        end
      ensure
        csv.close
      end
    end

    true
  ensure
    source_page.file.close
  end

  private

  attr_reader :source_page
end
