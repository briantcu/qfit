Here lies Quadfit.com (2012-2018)  
A subset of the functionality is screencapped [here](https://vimeo.com/282211743])

If you're interested in this project, shoot me a message.

Some notes:  
The base SQL needed to operate this application is not included in this repo.  
There are many static assets missing from this repo.  
This repo does include AWS elastic beanstalk config, and config to automatically deploy after a CircleCI build.  
The passwords/secrets have been removed from the /config directory  
The git history has been wiped  
Postgres, Redis, Sidekiq, Stripe, LogEntries, Segment, New Relic    

rake db:create:all
rake db:reset

yarn run dev

sidekiq -e development -L ./log/sidekiq.log -C ./config/sidekiq.yml
