# RUBY_VERSION="2.3"

# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo Installing $1
    shift
    sudo apt-get -y install "$@" >/dev/null 2>&1
}


sudo apt-get update
install "Ruby 2.3" ruby2.3
install 'Nokogiri dependencies' build-essential patch ruby-dev zlib1g-dev liblzma-dev
install 'Node JS' nodejs

sudo mkdir /var/log/webrick
sudo touch /var/log/webrick/error.log
sudo chown vagrant:vagrant /var/log/webrick/error.log
sudo touch /var/log/webrick/access.log
sudo chown vagrant:vagrant /var/log/webrick/access.log

sudo chown vagrant:vagrant /srv
echo "Cloning Hammer"
git clone https://github.com/wvuweb/hammer.git /srv/hammer

cd /srv/hammer/hammer/config/
echo "Giving vagrant ownership of hammer identity file"
sudo chown vagrant:vagrant hammer
echo "Setting correct permissions on identity file"
sudo chmod 600 hammer

cd /vagrant
echo "Getting Hammer-VM git branch"
branch=$(git symbolic-ref --short HEAD)

cd /srv/hammer
echo "Checking out $branch branch of Hammer Server"
git checkout $branch

cd /srv/hammer
echo "Installing Bundler and Bundle installing all Gems"
sudo gem install bundler
bundle install

echo 'Adding bitbucket as known identity'
ssh-keyscan bitbucket.org >> ~/.ssh/known_hosts
