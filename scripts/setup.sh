#!/bin/sh

# update the system
sudo apt-get update

################################################################################
# This is a port of the JHipster Dockerfile,
# see https://github.com/jhipster/jhipster-docker/
################################################################################

export JHIPSTER_VERSION='2.23.1'

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

# install yeoman grunt bower grunt gulp
sudo npm install -g yo bower grunt-cli gulp

# install JHipster
sudo npm install -g generator-jhipster@${JHIPSTER_VERSION}

################################################################################
# Install the graphical environment
################################################################################

# force encoding
sudo echo 'LANG=en_US.UTF-8' >> /etc/environment
sudo echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
sudo echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
sudo echo 'LC_CTYPE=en_US.UTF-8' >> /etc/environment

# install languages
sudo apt-get install language-pack-fr

# run GUI as non-privileged user
sudo echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config

# install Ubuntu desktop and VirtualBox guest tools
sudo apt-get install -y ubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
sudo apt-get install gnome-session-flashback

################################################################################
# Install the development tools
################################################################################

# install Eclipse
sudo mkdir /home/vagrant/applications
cd /home/vagrant/applications && sudo wget  http://dist.springsource.com/release/STS/3.7.1.RELEASE/dist/e4.5/spring-tool-suite-3.7.1.RELEASE-e4.5.1-linux-gtk-x86_64.tar.gz
cd /home/vagrant/applications && sudo tar -zxvf spring-tool-suite-3.7.1.RELEASE-e4.5.1-linux-gtk-x86_64.tar.gz

# install Chromium Browser
sudo apt-get install -y chromium-browser

# install MySQL
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mysql-server mysql-workbench
