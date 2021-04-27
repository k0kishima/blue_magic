require 'csv'

# TODO: バージョン追加された時点で修正する
class ParserClassFactory
  class << self
    def bulk_create!(object)
      strategy = case
                 when object.is_a?(Scraper)
                   CreateFromScraperStrategy.new(object)
                 when object.is_a?(Tempfile)
                   CreateFromCsvStrategy.new(object)
                 else
                   raise NotImplementedError.new("#{context} is invalid context to create parsers")
                 end
      strategy.bulk_create!
    end
  end
end

class CreateFromScraperStrategy
  def initialize(scraper)
    @scraper = scraper
  end

  def bulk_create!
    case scraper.class.name
    when 'OfficialWebsite::V1707::EventsScraper'
      [EventListParser]
    when 'OfficialWebsite::V1707::RacerProfilesScraper'
      [RacerListParser]
    when 'OfficialWebsite::V1707::RaceInformationsScraper'
      [RaceListParser]
    when 'OfficialWebsite::V1707::RaceEntriesScraper'
      [RaceEntryListParser, BoatBettingContributeRateAggregationParser, MotorBettingContributeRateAggregationParser,
       RacerWinningRateAggregationParser]
    when 'OfficialWebsite::V1707::RaceExhibitionRecordsScraper'
      [RaceExhibitionRecordsParser]
    when 'OfficialWebsite::V1707::RacerConditionsScraper'
      [RacerConditionListParser]
    when 'OfficialWebsite::V1707::WeatherConditionsScraper'
      [WeatherConditionListParser]
    when 'OfficialWebsite::V1707::RaceRecordsScraper'
      [RaceRecordListParser, DisqualifiedRaceEntryListParser, WinningRaceEntryListParser]
    when 'OfficialWebsite::V1707::PayoffsScraper'
      [PayoffListParser]
    when 'OfficialWebsite::V1707::OddsScraper'
      [OddsListParser]
    else
      raise NotImplementedError
    end
  end

  private

  attr_reader :scraper
end

class CreateFromCsvStrategy
  def initialize(csv)
    @csv = CSV.read(csv)
  end

  def bulk_create!
    # HACK: BaseImporter.subclesses が意図しない動作をする（空の配列返してくる）ので以下のように定数を直接指定して突合
    header = csv.first.map(&:to_sym)

    case header
    when BoatSettingListParser::HEADER_KEYS.map(&:to_sym)
      [BoatSettingListParser]
    when MotorMaintenanceListParser::HEADER_KEYS.map(&:to_sym)
      [MotorMaintenanceListParser]
    else
      raise NotImplementedError
    end
  end

  private

  attr_reader :csv
end
