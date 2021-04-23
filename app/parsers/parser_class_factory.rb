class ParserClassFactory
  def self.bulk_create!(scraper)
    # TODO: バージョン追加された時点で修正する
    case scraper.class.name
    when 'OfficialWebsite::V1707::EventsScraper'
      [EventListParser]
    when 'OfficialWebsite::V1707::RacerProfilesScraper'
      [RacerListParser]
    else
      raise NotImplementedError
    end
  end
end
