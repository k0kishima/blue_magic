module OfficialWebsite
  class ScraperClassFactory
    USE_VERSION = Rails.application.config.x.official_website_proxy.latest_official_website_version

    class << self
      # TODO: 要修正
      # 引数にページオブジェクト渡して
      # case page.class.name
      #  when 'OfficialWebsite::EventSchedulePage'
      #    'events'
      # ...
      # みたいに分岐するように考えたが、ページに対して対応するスクレイパーは複数ある場合があるのでそのケースだと一意なマッピングができない
      def create!(resource_name, version: USE_VERSION)
        "OfficialWebsite::V#{version}::#{resource_name.pluralize.camelize}Scraper".constantize
      rescue NameError
        raise ArgumentError.new("cannot create a scraper for #{resource_name} version #{version}")
      end
    end
  end
end
