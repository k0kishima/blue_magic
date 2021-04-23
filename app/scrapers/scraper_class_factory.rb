class ScraperClassFactory
  def self.bulk_create!(page)
    # TODO: バージョン追加された時点で修正する
    case page.class.name
    when 'OfficialWebsite::EventSchedulePage'
      [OfficialWebsite::V1707::EventsScraper]
    else
      raise NotImplementedError
    end
  end
end
