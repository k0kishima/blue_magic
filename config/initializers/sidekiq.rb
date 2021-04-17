redis_config = {
  url: ENV.fetch('REDIS_URL') { 'redis://redis:6379' },
  namespace: "#{Rails.application.class.module_parent_name.underscore.downcase}:#{Rails.env}:sidekiq",
}

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
