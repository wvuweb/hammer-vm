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
install Ruby ruby2.3 ruby2.3-dev

echo installing Bundler
gem install bundler

install Git git

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev liblzma-dev zlib1g-dev
install 'ExecJS runtime' nodejs

git clone https://github.com/wvuweb/hammer.git /srv/hammer


# check branch of hammer-vm if in dev switch hammer branch to dev
cd /vagrant
branch=$(git symbolic-ref --short HEAD)
cd /srv/hammer
if [ "$branch"="dev" ]; then
  echo "Checking out dev branch of Hammer"
  git checkout dev
fi

#install hammer bundle
bundle install

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8
