require 'open-uri'

class OfficialWebsite::CrawlJob < ApplicationJob
  DEFAULT_VERSION = Rails.application.config.x.official_website_proxy.latest_official_website_version

  include PageReloadable
  include CrawlingNotifiable

  discard_on Slack::Web::Api::Errors::TooManyRequestsError
  discard_on(ArgumentError, StandardError) do |job, error|
    message = {
      exception_class: error.class,
      error_message: error.message,
      job_name: job.class.name,
      arguments: job.arguments.to_s,
    }.map { |key, value| [key, value].join(': ') }.join("\n")
    job.notify_error(message)
  end

  retry_on DataNotFound, wait: 3.minutes, attempts: 3 do |job, _|
    # これはリトライを諦めた時の処理なので注意
    job.notify_information("this race has been discarded because of data not found #{job.attempt_number} count")
  end

  retry_on OpenURI::HTTPError, wait: 1.minutes, attempts: 3
  retry_on Net::OpenTimeout, wait: 1.minutes, attempts: 3
  retry_on NoMethodError, wait: 3.minutes, attempts: 3
end
