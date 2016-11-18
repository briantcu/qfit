if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://quadfit.t9e3qk.0001.usw1.cache.amazonaws.com:6379/12' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://quadfit.t9e3qk.0001.usw1.cache.amazonaws.com:6379/12' }
  end
end
