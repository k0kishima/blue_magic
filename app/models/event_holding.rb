class EventHolding
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :stadium_tel_code, :integer
  attribute :date, :date

  validates :stadium_tel_code, presence: true, inclusion: { in: Stadium::TELCODE_RANGE }
  validates :date, presence: true

  def self.opened_on(date)
    page = OfficialWebsite::EventHoldingsPage.new(date: date)

    begin
      scraper_class = OfficialWebsite::ScraperClassFactory.create!(self.name)
      scraper = scraper_class.new(file: page.file)
      scraper.scrape!.reject do |hash|
        hash.fetch(:day_text).include?('中止')
      end.map do |hash|
        new(date: date, stadium_tel_code: hash.fetch(:stadium_tel_code))
      end
    ensure
      page.file.close
    end
  end
end
