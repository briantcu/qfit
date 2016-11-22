God.pid_file_directory = '/home/ec2-user/pids'

God::Contacts::Email.defaults do |d|
  d.from_email = 'web@quadfit.com'
  d.from_name = 'God'
  d.delivery_method = :sendmail
end
God.contact(:email) do |c|
  c.name = 'brian'
  c.to_email = 'brian@quadfit.com'
end

rails_env = 'production'
app_root = "/var/app/current"

name_prefix = "god-sidekiq-#{rails_env}"
num_workers = 1
name = 'sidekiq'

num_workers.times do |num|
  God.watch do |w|
    w.name = "#{name_prefix}-#{num}"
    w.group = 'sidekiq'
    w.env = { 'RAILS_ENV' => rails_env, 'QUEUE' => '*' }
    w.dir = app_root

    # pid file is important! because sidekiq will be running as daemonized process
    w.pid_file = File.join(app_root, "tmp/pids/", "#{name}.pid")
    w.log  = File.join(app_root, 'log', "#{name}.log")

    # run sidekiq as daemon
    w.start = "bundle exec sidekiq -e #{rails_env} -C #{app_root}/config/sidekiq.yml &"
    w.stop  = "kill -TERM `cat #{w.pid_file}`"

    w.keepalive
    w.behavior(:clean_pid_file)

    w.transition(:up, :start) do |on|
      on.condition(:process_exits) do |c|
        c.notify = 'brian'
      end
    end
  end
end