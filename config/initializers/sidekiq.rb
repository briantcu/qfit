Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost.com:6379/1' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost.com:6379/1' }
end