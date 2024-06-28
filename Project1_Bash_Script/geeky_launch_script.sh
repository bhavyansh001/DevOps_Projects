#!/bin/bash

# The script is based on deploy guide by GoRails @ https://gorails.com/deploy/ubuntu/22.04
# To see how I used this srcipt for spinning up an EC2 instance: https://diversepixel.medium.com/deploying-geeky-using-aws-cli-devops-project-01-5f0a9035e70b
# Github repo for project Geeky: https://github.com/bhavyansh001/geeky_01 branch: deploy_aws_cli

# Start the script with superuser privileges
sudo -i

# Prompt for application name and keys
app_name=
rails_master_key=
secret_key_base=
deploy_password=
db_password=

# Create log file
log_file="/var/log/deploy_script.log"
exec > >(tee -i $log_file) 2>&1

# 1. Create a new user 'deploy' and add it to sudo group
adduser --disabled-password --gecos "" deploy
echo "deploy:$deploy_password" | chpasswd
usermod -aG sudo deploy

# 2. Install ruby dependencies
# Adding Node.js repository
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# Adding Yarn repository
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Adding Redis repository
sudo add-apt-repository ppa:chris-lea/redis-server -y

# Refresh packages list with the new repositories and install dependencies
sudo apt-get update
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev \
libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg \
apt-transport-https ca-certificates redis-server redis-tools nodejs yarn

# 3. Install rbenv (initial setup)
sudo -u deploy -H bash -c '
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  echo '"'"'export PATH="$HOME/.rbenv/bin:$PATH"'"'"' >> ~/.bashrc
  echo '"'"'eval "$(rbenv init -)"'"'"' >> ~/.bashrc
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo '"'"'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"'"'"' >> ~/.bashrc
  git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars
  source ~/.bashrc
'

# 4. Install Nginx and Passenger
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger $(lsb_release -cs) main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update
sudo apt-get install -y nginx-extras libnginx-mod-http-passenger

if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then
  sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf
fi
sudo ls /etc/nginx/conf.d/mod-http-passenger.conf

# Configure Passenger with the correct Ruby version
sudo bash -c "cat > /etc/nginx/conf.d/mod-http-passenger.conf <<EOF
### Begin automatically installed Phusion Passenger config snippet ###
passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
passenger_ruby /home/deploy/.rbenv/shims/ruby;

passenger_instance_registry_dir /var/run/passenger-instreg;

### End automatically installed Phusion Passenger config snippet ###
EOF"

# 5. Start nginx and remove default site
sudo service nginx start
sudo rm /etc/nginx/sites-enabled/default

# Create NGINX config for the app
sudo bash -c "cat > /etc/nginx/sites-enabled/$app_name <<EOF
server {
  listen 80;
  listen [::]:80;

  server_name _;
  root /home/deploy/$app_name/current/public;

  passenger_enabled on;
  passenger_app_env production;

  location /cable {
    passenger_app_group_name ${app_name}_websocket;
    passenger_force_max_concurrent_requests_per_process 0;
  }

  client_max_body_size 100m;

  location ~ ^/(assets|packs) {
    expires max;
    gzip_static on;
  }
}
EOF"

# Reload NGINX to apply changes
sudo service nginx reload

# 6. Setup PostgreSQL database
sudo apt-get install -y postgresql postgresql-contrib libpq-dev
sudo -u postgres psql -c "CREATE USER deploy WITH PASSWORD '$db_password';"
sudo -u postgres createdb -O deploy $app_name

# 7. Create app directory and setup environment variables
sudo -u deploy mkdir -p /home/deploy/$app_name
sudo -u deploy bash -c "cat > /home/deploy/$app_name/.rbenv-vars <<EOF
DATABASE_URL=postgresql://deploy:$db_password@127.0.0.1/$app_name
RAILS_MASTER_KEY=$rails_master_key
SECRET_KEY_BASE=$secret_key_base
EOF"

# 8. Install Ruby (time-consuming part, placed at the end) fails, requires manual setup
sudo -i
sudo -u deploy -H bash -c '
  source ~/.bashrc
  rbenv install 3.2.0
  rbenv global 3.2.0
  gem install bundler
'

echo "Deployment setup complete."
