# RUBY_VERSION="2.3"

# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo Installing $1
    shift
    sudo apt-get -y install "$@" >/dev/null 2>&1
}

echo "Updating system packages..."
sudo apt-get -qq update
install "Ruby 2.4" ruby2.4
install 'Nokogiri dependencies' build-essential patch ruby-dev zlib1g-dev liblzma-dev
install 'Node JS' nodejs

WEB_BRICK_LOG_DIR="/var/log/webrick"
if [ ! -d $WEB_BRICK_LOG_DIR ]; then
  sudo mkdir $WEB_BRICK_LOG_DIR
  sudo touch $WEB_BRICK_LOG_DIR/error.log
  sudo chown vagrant:vagrant $WEB_BRICK_LOG_DIR/error.log
  sudo touch $WEB_BRICK_LOG_DIR/access.log
  sudo chown vagrant:vagrant $WEB_BRICK_LOG_DIR/access.log
else
  echo "$WEB_BRICK_LOG_DIR already exists moving on ..."
fi

sudo chown vagrant:vagrant /srv

if [ -d /srv/hammer ]; then
  sudo rm -rf /srv/hammer
fi

echo "Cloning Hammer"
git clone https://github.com/wvuweb/hammer.git /srv/hammer --quiet
cd /srv/hammer/hammer/config/
echo "Giving vagrant ownership of Hammer identity file"
sudo chown vagrant:vagrant hammer
echo "Setting correct permissions on identity file"
sudo chmod 600 hammer

if [ $HAMMER_VERSION != false ]; then
  cd /srv/hammer
  echo "Checking out version $HAMMER_VERSION of Hammer Server"
  git checkout $HAMMER_VERSION --quiet
# If development environment pull from branch checkedout on.
elif [ $DEV_ENVIRONMENT == true ] ; then
  cd /vagrant
  echo "Getting Hammer-VM git branch"
  branch=$(git symbolic-ref --short HEAD)
  description=$(git describe)
  cd /srv/hammer
  echo "Checking out $branch at $describe branch of Hammer Server"
  git checkout $branch --quiet
else
  # install the latest tagged release
  cd /srv/hammer
  latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
  echo "Checking out latest version $latestTag of Hammer Server"
  git checkout $latestTag --quiet
fi


cd /srv/hammer
echo "Installing Bundler"
sudo gem install bundler --quiet
echo "Installing all gem dependencies. This may take some time, be patient..."
# only install needed gems, no development gems like pry
bundle install --without development --quiet

touch /home/vagrant/.ssh/config
chmod 600 /home/vagrant/.ssh/config

cat > /home/vagrant/.ssh/config << EOL
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    LogLevel ERROR
EOL

echo 'Adding bitbucket as known identity'
ssh-keyscan bitbucket.org >> ~/.ssh/known_hosts
