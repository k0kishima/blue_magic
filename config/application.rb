require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BlueMagic
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :local

    config.active_job.queue_adapter = :sidekiq

    config.x.official_website_proxy.base_url = ENV.fetch('OFFICIAL_WEBSITE_PROXY_BASE_URL') { 'http://host.docker.internal:55000' }
    config.x.official_website_proxy.latest_official_website_version = ENV.fetch('LATEST_OFFICIAL_WEBSITE_VERSION') { 1707 }

    config.x.teleboat_agent.api_base_url = ENV.fetch('TELEBOAT_AGENT_API_BASE_URL') { 'http://host.docker.internal:9999' }
    config.x.teleboat_agent.application_token = ENV.fetch('TELEBOAT_AGENT_API_APPLICATION_TOKEN') { 'foobar' }
  end
end
