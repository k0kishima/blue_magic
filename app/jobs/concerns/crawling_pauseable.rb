module CrawlingPauseable
  extend ActiveSupport::Concern
  include CrawlingNotifiable

  included do
    discard_on(CrawlingDisabled) do |job, error|
      job.notify_information('cralwer have been disabled now.')
    end

    before_perform :pause_crawling!

    private

    def pause_crawling!
      raise CrawlingDisabled unless Setting.crawling_enable
    end
  end
end
