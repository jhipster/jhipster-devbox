#!/bin/sh

# update the system
sudo apt-get update

################################################################################
# This is a port of the JHipster Dockerfile,
# see https://github.com/jhipster/jhipster-docker/
################################################################################

export JAVA_VERSION='8'
export JAVA_HOME='/usr/lib/jvm/java-8-oracle'

export MAVEN_VERSION='3.3.3'
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
sudo curl -fsSL http://archive.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz | sudo tar xzf - -C /usr/share && sudo mv /usr/share/apache-maven-3.3.3 /usr/share/maven && sudo ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# install node.js
sudo curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
sudo apt-get install -y nodejs unzip python g++ build-essential

# update npm
sudo npm install -g npm

# install yeoman grunt bower grunt gulp
sudo npm install -g yo bower grunt-cli gulp

# install JHipster
sudo npm install -g generator-jhipster

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
export STS_VERSION='3.7.1.RELEASE'

cd /opt && wget  http://dist.springsource.com/release/STS/${STS_VERSION}/dist/e4.5/spring-tool-suite-${STS_VERSION}-e4.5.1-linux-gtk-x86_64.tar.gz
cd /opt && tar -zxvf spring-tool-suite-${STS_VERSION}-e4.5.1-linux-gtk-x86_64.tar.gz
sudo chown -R vagrant:vagrant /opt
cd /home/vagrant

# install Atom
export ATOM_VERSION='v1.2.0'

wget https://github.com/atom/atom/releases/download/${ATOM_VERSION}/atom-amd64.deb atom-amd64.deb
sudo dpkg -i atom-amd64.deb
rm -f atom-amd64.deb

# install Chromium Browser
sudo apt-get install -y chromium-browser

# install mysql-workbench
sudo apt-get install -y mysql-workbench

# install Heroku toolbelt
sudo wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# install Cloud Foundry client
cd /opt && sudo curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx
sudo ln -s /opt/cf /usr/bin/cf
cd /home/vagrant

# install Guake
sudo apt-get install -y guake
sudo cp /usr/share/applications/guake.desktop /etc/xdg/autostart/

# docker needs these installs
sudo apt-get install -y lxc bsdtar
sudo apt-get install -y linux-image-extra-$(uname -r)
sudo modprobe aufs

# install docker
curl -sSL https://get.docker.com/ | sh

# install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.5.1/docker-compose-`uname -s`-`uname -m` > docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# optimize docker experience
source /etc/bash_completion.d/docker
sudo usermod -aG docker vagrant

# provide m2
mkdir -p /home/vagrant/.m2
git clone https://github.com/jhipster/jhipster-travis-build /home/vagrant/jhipster-travis-build
mv /home/vagrant/jhipster-travis-build/repository /home/vagrant/.m2/
rm -Rf /home/vagrant/jhipster-travis-build

# create shortcuts
sudo mkdir /home/vagrant/Desktop
ln -s /opt/sts-bundle/sts-${STS_VERSION}/STS /home/vagrant/Desktop/STS
sudo chown -R vagrant:vagrant /home/vagrant
