#!/bin/bash
bundle install
rake db:create  RAILS_ENV=production
rake db:migrate RAILS_ENV=production
echo "Preparing database. Please be patient, I have a ton of info to leech..."
rake db:setup RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1
echo "I'm ready!"
bundle exec rails s -p 3000 -b '0.0.0.0'