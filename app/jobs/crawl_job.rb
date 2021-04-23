require 'open-uri'

class CrawlJob < ApplicationJob
  DEFAULT_VERSION = Rails.application.config.x.official_website_proxy.latest_official_website_version

  include PageReloadable

  retry_on OpenURI::HTTPError, wait: 1.minutes, attempts: 3
  retry_on Net::OpenTimeout, wait: 1.minutes, attempts: 3
end
