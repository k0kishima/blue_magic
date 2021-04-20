class Scraper
  include Publishable

  attr_reader :cache

  def initialize(file)
    @file = file
  end

  def cache!
    self.cache = scrape!
  end

  def cache=(data)
    @cache = data
    notify_observers
  end
end
