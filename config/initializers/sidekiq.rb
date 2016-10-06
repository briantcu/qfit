if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://quadfit-dev.89gbzf.0001.use1.cache.amazonaws.com:6379/12' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://quadfit-dev.89gbzf.0001.use1.cache.amazonaws.com:6379/12' }
  end
end
