# NOTE: 責務の範囲はリソースの情報をダウンロードして購読者に通知するのみ
module OfficialWebsite
  class Crawler
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :source_page
    validates :source_page, presence: true

    attr_reader :downloaded_file

    def crawl!
      validate!
      self.downloaded_file = source_page.file
      true
    end

    def add_observer(observer)
      @observers ||= []
      @observers << observer
    end

    private

    def downloaded_file=(new_downloaded_file)
      @downloaded_file = new_downloaded_file
      notify_observers
    end

    def notify_observers
      observers.each do |observer|
        observer.subscribe(self)
      end
    end

    def observers
      @observers || []
    end
  end
end
