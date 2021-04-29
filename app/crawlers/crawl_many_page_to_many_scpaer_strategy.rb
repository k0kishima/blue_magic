class CrawlManyPageToManyScpaerStrategy
  def initialize(source_pages)
    @source_pages = source_pages
  end

  def crawl!
    array_of_available_scraper_array = source_pages.map do |source_page|
      scraper_classes = ScraperClassFactory.bulk_create!(source_page, context: :cross_pages)
      scraper_classes.map { |scraper_class| scraper_class.new(file: source_page.file) }
    end
    products = array_of_available_scraper_array.inject(:product).map(&:flatten)

    products.each do |scrapers|
      array_of_scraped_data = scrapers.map { |scraper| scraper.scrape! }
      csv = CsvFactory.create!(*array_of_scraped_data)

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
    source_pages.each { |source_page| source_page.file.close }
  end

  private

  attr_reader :source_pages
end
