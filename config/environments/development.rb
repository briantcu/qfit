Qfit::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  config.active_record.raise_in_transactional_callbacks = true
  # Do not eager load code on boot.
  config.eager_load = false

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.smtp_settings = {
      :address => "email-smtp.us-east-1.amazonaws.com",
      :port => 587,
      :user_name => 'AKIAIAWCM4K6K5S4KHPQ',
      :password => 'ApZGmkzQ96snhfuZzGqggQmychbEUadDQFvEq7xmQMXr',
      :authentication => :login,
      :enable_starttls_auto => true
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  config.assets_prefix = ''
  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.token_salt = 'lajdfl;jasdkkkfjfjalsjeinvidk'
end
