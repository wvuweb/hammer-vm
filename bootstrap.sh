# RUBY VERSION
RUBY_VERSION="2.3.3"

# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential
# install Ruby ruby2.3 ruby2.3-dev
install 'packages needed for ruby install' libssl-dev libreadline-dev

install Git git

# Create a directory for source downloads to be compiled
cd ~
mkdir src
cd src

# Install ruby-install
# https://github.com/postmodern/ruby-install#readme
wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz
tar -xzvf ruby-install-0.5.0.tar.gz
cd ruby-install-0.5.0/
sudo make install
cd ..
rm -rf ruby-install-0.5.0

# Install chruby
# https://github.com/postmodern/chruby#readme
wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install
cd ..
rm -rf chruby-0.3.9

# Install Ruby
#ruby-install ruby 1.9.3-p484
ruby-install ruby $RUBY_VERSION

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby $RUBY_VERSION

# install chruby system wide
cat <<EOF > /etc/profile.d/chruby.sh
if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi
EOF

# Create a symlink to the Ruby we want passenger to use
sudo ln -s $(which ruby) /usr/local/bin/passenger-ruby

echo installing Bundler
gem install bundler

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev liblzma-dev zlib1g-dev
install 'ExecJS runtime' nodejs

git clone https://github.com/wvuweb/hammer.git /srv/hammer

# check branch of hammer-vm if in dev switch hammer branch to dev
cd /vagrant
branch=$(git symbolic-ref --short HEAD)

cd /srv/hammer
chruby $RUBY_VERSION
if [ "$branch"="dev" ]; then
  echo "Checking out dev branch of Hammer"
  git checkout dev
fi

cd /srv/hammer
#install hammer bundle
bundle install

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8
