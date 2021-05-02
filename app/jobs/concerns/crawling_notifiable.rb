module CrawlingNotifiable
  extend ActiveSupport::Concern

  module CHANNEL_NAMES
    EMERGENCY = '001_crawler_emergency'
    INFORMATION = '001_crawler_info'
  end

  included do
    def notify_error(message)
      slack_client.chat_postMessage(channel: CHANNEL_NAMES::EMERGENCY, text: message)
    end

    def notify_information(message)
      slack_client.chat_postMessage(channel: CHANNEL_NAMES::INFORMATION, text: message)
    end

    private

    def slack_client
      @slack_client ||= Slack::Web::Client.new
    end
  end
end
