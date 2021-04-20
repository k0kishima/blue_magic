# NOTE: 責務の範囲はリソースの情報をダウンロードして購読者に通知するのみ
module OfficialWebsite
  class Crawler
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations
    include Publishable

    attribute :source_page
    validates :source_page, presence: true

    attr_reader :downloaded_file

    def crawl!
      validate!
      self.downloaded_file = source_page.file
      true
    end

    private

    def downloaded_file=(new_downloaded_file)
      @downloaded_file = new_downloaded_file
      notify_observers
    end
  end
end
