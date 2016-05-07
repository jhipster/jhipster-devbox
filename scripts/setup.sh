#!/bin/sh

# update the system
apt-get update
apt-get upgrade

################################################################################
# This is a port of the JHipster Dockerfile,
# see https://github.com/jhipster/jhipster-docker/
################################################################################

export MAVEN_VERSION='3.3.9'
export MAVEN_HOME='/usr/share/maven'
export PATH=$PATH:$MAVEN_HOME/bin

export LANGUAGE='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
locale-gen en_US.UTF-8
dpkg-reconfigure locales

# install utilities
apt-get -y install vim git zip bzip2 fontconfig curl openjdk-8-jdk

apt-get update

# install maven
curl -fsSL http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar xzf - -C /usr/share && mv /usr/share/apache-maven-${MAVEN_VERSION} /usr/share/maven && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# install node.js
curl -sL https://deb.nodesource.com/setup_4.x | bash -
apt-get install -y nodejs unzip python g++ build-essential

# update npm
npm install -g npm

# install yeoman grunt bower gulp
npm install -g yo bower gulp

# install JHipster
npm install -g generator-jhipster@3.2.0

# install JHipster UML
npm install -g jhipster-uml@1.6.5

################################################################################
# Install the graphical environment
################################################################################

# force encoding
echo 'LANG=en_US.UTF-8' >> /etc/environment
echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
echo 'LC_CTYPE=en_US.UTF-8' >> /etc/environment

# install languages
apt-get install -y language-pack-fr

# run GUI as non-privileged user
echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config

# install Ubuntu desktop and VirtualBox guest tools
apt-get install -y ubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
apt-get install -y gnome-session-flashback

apt-get update
apt-get upgrade

################################################################################
# Install the development tools
################################################################################

# install Ubuntu Make - see https://wiki.ubuntu.com/ubuntu-make

add-apt-repository -y ppa:ubuntu-desktop/ubuntu-make

apt-get update
apt-get upgrade

apt install -y ubuntu-make

# install Chromium Browser
apt-get install -y chromium-browser

# install MySQL Workbench
apt-get install -y mysql-workbench

# install PgAdmin
apt-get install -y pgadmin3

# install Heroku toolbelt
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# install Cloud Foundry client
cd /opt && curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx
ln -s /opt/cf /usr/bin/cf

#install Guake
apt-get install -y guake
cp /usr/share/applications/guake.desktop /etc/xdg/autostart/

# install Atom

wget https://github.com/atom/atom/releases/download/v1.7.3/atom-amd64.deb
dpkg -i atom-amd64.deb
rm -f atom-amd64.deb
dpkg --configure -a

# install Docker
curl -sL https://get.docker.io/ | sh

# install docker compose
curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

################################################################################
# Create JHipster user
################################################################################

useradd jhipster --password xTZgpKFPrv2fA --home /home/jhipster --create-home
adduser jhipster sudo

# configure docker group (docker commands can be launched without sudo)
usermod -aG docker jhipster

# clean the box
apt-get clean
dd if=/dev/zero of=/EMPTY bs=1M > /dev/null 2>&1
rm -f /EMPTY
