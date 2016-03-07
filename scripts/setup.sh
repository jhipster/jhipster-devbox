#!/bin/sh

# update the system
sudo apt-get update
sudo apt-get upgrade

################################################################################
# This is a port of the JHipster Dockerfile,
# see https://github.com/jhipster/jhipster-docker/
################################################################################

export JAVA_VERSION='8'
export JAVA_HOME='/usr/lib/jvm/java-8-oracle'

export MAVEN_VERSION='3.3.9'
export MAVEN_HOME='/usr/share/maven'
export PATH=$PATH:$MAVEN_HOME/bin

export LANGUAGE='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
sudo locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales

# install utilities
sudo apt-get -y install vim git sudo zip bzip2 fontconfig curl

# install Java 8
sudo echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list
sudo echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886

sudo apt-get update

sudo echo oracle-java-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get install -y --force-yes oracle-java${JAVA_VERSION}-installer
sudo  update-java-alternatives -s java-8-oracle

# install maven
sudo curl -fsSL http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | sudo tar xzf - -C /usr/share && sudo mv /usr/share/apache-maven-${MAVEN_VERSION} /usr/share/maven && sudo ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# install node.js
sudo curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
sudo apt-get install -y nodejs unzip python g++ build-essential

# update npm
sudo npm install -g npm

# install yeoman grunt bower grunt gulp
sudo npm install -g yo bower grunt-cli gulp

# install JHipster
sudo npm install -g generator-jhipster@2.27.1

################################################################################
# Install the graphical environment
################################################################################

# force encoding
sudo echo 'LANG=en_US.UTF-8' >> /etc/environment
sudo echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
sudo echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
sudo echo 'LC_CTYPE=en_US.UTF-8' >> /etc/environment

# install languages
sudo apt-get install -y language-pack-fr

# run GUI as non-privileged user
sudo echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config

# install Ubuntu desktop and VirtualBox guest tools
sudo apt-get install -y ubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
sudo apt-get install -y gnome-session-flashback

################################################################################
# Install the development tools
################################################################################

# install Spring Tool Suite
export STS_VERSION='3.7.2.RELEASE'

cd /opt && wget  http://dist.springsource.com/release/STS/${STS_VERSION}/dist/e4.5/spring-tool-suite-${STS_VERSION}-e4.5.1-linux-gtk-x86_64.tar.gz
cd /opt && tar -zxvf spring-tool-suite-${STS_VERSION}-e4.5.1-linux-gtk-x86_64.tar.gz
cd /opt && rm -f spring-tool-suite-${STS_VERSION}-e4.5.1-linux-gtk-x86_64.tar.gz
sudo chown -R vagrant:vagrant /opt
cd /home/vagrant

# install Chromium Browser
sudo apt-get install -y chromium-browser

# install MySQL with default passwoard as 'vagrant'
export DEBIAN_FRONTEND=noninteractive
echo 'mysql-server mysql-server/root_password password vagrant' | sudo debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password vagrant' | sudo debconf-set-selections
sudo apt-get install -y mysql-server mysql-workbench

# install Heroku toolbelt
sudo wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# install Cloud Foundry client
cd /opt && sudo curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx
sudo ln -s /opt/cf /usr/bin/cf
cd /home/vagrant

#install Guake
sudo apt-get install -y guake
sudo cp /usr/share/applications/guake.desktop /etc/xdg/autostart/

# install Atom

wget https://github.com/atom/atom/releases/download/v1.5.3/atom-amd64.deb
sudo dpkg -i atom-amd64.deb
rm -f atom-amd64.deb
sudo dpkg --configure -a

# install Docker
curl -sL https://get.docker.io/ | sudo sh

# configure docker group (docker commands can be launched without sudo)
sudo usermod -aG docker vagrant

# install docker compose
sudo curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# provide m2
mkdir -p /home/vagrant/.m2
git clone https://github.com/jhipster/jhipster-travis-build /home/vagrant/jhipster-travis-build
mv /home/vagrant/jhipster-travis-build/repository /home/vagrant/.m2/
rm -Rf /home/vagrant/jhipster-travis-build

# create shortcuts
sudo mkdir /home/vagrant/Desktop
ln -s /opt/sts-bundle/sts-${STS_VERSION}/STS /home/vagrant/Desktop/STS
sudo chown -R vagrant:vagrant /home/vagrant

# clean the box
sudo apt-get clean
dd if=/dev/zero of=/EMPTY bs=1M > /dev/null 2>&1
rm -f /EMPTY
