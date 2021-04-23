class ParserClassFactory
  def self.bulk_create!(scraper)
    # TODO: バージョン追加された時点で修正する
    case
    when 'OfficialWebsite::V1707::EventsScraper'
      [EventListParser]
    else
      raise NotImplementedError
    end
  end
end
