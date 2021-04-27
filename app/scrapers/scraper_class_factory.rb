# TODO: バージョン追加された時点で修正する
class ScraperClassFactory
  class << self
    def bulk_create!(page, context: :single_page)
      strategy = case context.to_sym
                 when :single_page
                   CreateSinglePageToManyScpaerStrategy.new(page)
                 when :cross_pages
                   CreateManyPageToManyScpaerStrategy.new(page)
                 else
                   raise NotImplementedError.new("#{context} is invalid context to create scrapers")
                 end
      strategy.bulk_create!
    end
  end
end

class CreateSinglePageToManyScpaerStrategy
  def initialize(page)
    @page = page
  end

  def bulk_create!
    case page.class.name
    when 'OfficialWebsite::EventSchedulePage'
      [OfficialWebsite::V1707::EventsScraper]
    when 'OfficialWebsite::RacerProfilePage'
      [OfficialWebsite::V1707::RacerProfilesScraper]
    when 'OfficialWebsite::EventHoldingsPage'
      [OfficialWebsite::V1707::EventHoldingsScraper]
    when 'OfficialWebsite::EventEntriesPage'
      [OfficialWebsite::V1707::EventEntriesScraper]
    when 'OfficialWebsite::RaceInformationPage'
      [OfficialWebsite::V1707::RaceInformationsScraper, OfficialWebsite::V1707::RaceEntriesScraper]
    when 'OfficialWebsite::RaceExhibitionInformationPage'
      [OfficialWebsite::V1707::RaceExhibitionRecordsScraper, OfficialWebsite::V1707::RacerConditionsScraper,
       OfficialWebsite::V1707::WeatherConditionsScraper]
    when 'OfficialWebsite::RaceResultPage'
      # NOTE: 気象情報は展示と本番それぞれで取る
      [OfficialWebsite::V1707::WeatherConditionsScraper, OfficialWebsite::V1707::RaceRecordsScraper,
       OfficialWebsite::V1707::PayoffsScraper]
    when 'OfficialWebsite::RaceOddsPage'
      [OfficialWebsite::V1707::OddsScraper]
    else
      raise NotImplementedError
    end
  end

  private

  attr_reader :page
end

class CreateManyPageToManyScpaerStrategy
  def initialize(page)
    @page = page
  end

  def bulk_create!
    case page.class.name
    when 'OfficialWebsite::RaceInformationPage'
      [OfficialWebsite::V1707::RaceEntriesScraper]
    when 'OfficialWebsite::RaceExhibitionInformationPage'
      [OfficialWebsite::V1707::BoatSettingsScraper, OfficialWebsite::V1707::MotorMaintenancesScraper,]
    else
      raise NotImplementedError
    end
  end

  private

  attr_reader :page
end
