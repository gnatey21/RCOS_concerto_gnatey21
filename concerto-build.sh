#! /bin/bash
#The following script should install concerto, it's dependencies, and start a server on localhost
#Should the server be stopped once built, running this script again will be unneceary, as the server can be stared again with:

# install dependencies
apt-get install -y build-essential apt-transport-https libapache2-mod-passenger ruby-full ruby-dev libruby imagemagick ruby-rmagick libmagickcore-dev libmagickwand-dev libssl-dev zlib1g-dev libsqlite3-dev default-mysql-server libpq-dev default-mysql-client ruby-mysql2 default-libmysqlclient-dev apache2 libxslt1-dev nodejs git

#At this point, must ensure we are using ruby version 2.6.0
apt install rbenv
rbenv init
rbenv install 2.6.0
rbenv global 2.6.0

gem install bundler

# only need these three lines if you want to import various document formats to slides
add-apt-repository ppa:libreoffice/ppa
apt-get update
apt install -y libreoffice ghostscript libgs-dev gsfonts poppler-utils

# install our application (relative to whereever you currently are)
git clone https://github.com/concerto/concerto.git
cd concerto

# remember to prepend each of these next commands with RAILS_ENV=environment, if needed
# for example:  RAILS_ENV=production bundle install --path vendor/bundle
RAILS_ENV=development bundle install --path vendor/bundle
RAILS_ENV=development bundle exec rake db:migrate
RAILS_ENV=development bundle exec rake db:seed
# When Concerto is started up, it will by default execute those three commands above.
# However, they may also be run manually and automatic migration and bundle installation 
# can be disabled in config/concerto.yml.

cp concerto-init.d /etc/init.d/concerto
update-rc.d concerto defaults

#Now, start server:
RAILS_ENV=development bundle exec rails server
