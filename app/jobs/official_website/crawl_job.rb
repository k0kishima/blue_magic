require 'open-uri'

class OfficialWebsite::CrawlJob < ApplicationJob
  DEFAULT_VERSION = Rails.application.config.x.official_website_proxy.latest_official_website_version

  include PageReloadable
  include CrawlingNotifiable

  discard_on(ArgumentError) do |job, error|
    message = {
      error_message: error.message,
      job_name: job.class.name,
      arguments: job.arguments.to_s,
    }.map { |key, value| [key, value].join(': ') }.join("\n")
    job.notify_error(message)
  end

  retry_on OpenURI::HTTPError, wait: 1.minutes, attempts: 3
  retry_on Net::OpenTimeout, wait: 1.minutes, attempts: 3
end
