CarrierWave.configure do |config|

  config.fog_credentials = {
      :provider               => "AWS",
      :region                 => 'us-east-1',
      :aws_access_key_id      => 'AKIAIQE6XTBJVB4T257A',
      :aws_secret_access_key  => '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'
  }

  if Rails.env.production?
    config.root = Rails.root.join('tmp')
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end

  config.fog_directory  = 'qfavis'
end