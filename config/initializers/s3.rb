CarrierWave.configure do |config|

  config.fog_credentials = {
      :provider               => "AWS",
      :region                 => 'us-east-1',
      :aws_access_key_id      => '',
      :aws_secret_access_key  => ''
  }

  if Rails.env.production?
    config.root = Rails.root.join('tmp')
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end

  config.fog_directory  = 'qfavis'
end