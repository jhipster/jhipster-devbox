#!/bin/sh

# update the system
apt-get update
apt-get upgrade

################################################################################
# This is a port of the JHipster Dockerfile,
# see https://github.com/jhipster/jhipster-docker/
################################################################################

export LANGUAGE='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
locale-gen en_US.UTF-8
dpkg-reconfigure locales

# install utilities
apt-get -y install vim git zip bzip2 fontconfig curl language-pack-en

# install Java 8
echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list
echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886

apt-get update

echo oracle-java-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get install -y --force-yes oracle-java8-installer
update-java-alternatives -s java-8-oracle

# install node.js
curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get install -y nodejs unzip python g++ build-essential

# update npm
npm install -g npm

# install yeoman grunt bower gulp
npm install -g yo bower gulp

# install JHipster
npm install -g generator-jhipster@4.0.0

# install JHipster UML
npm install -g jhipster-uml@2.0.3

################################################################################
# Install the graphical environment
################################################################################

# force encoding
echo 'LANG=en_US.UTF-8' >> /etc/environment
echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
echo 'LC_CTYPE=en_US.UTF-8' >> /etc/environment

# run GUI as non-privileged user
echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config

# install Ubuntu desktop and VirtualBox guest tools
apt-get install -y xubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

# remove light-locker (see https://github.com/jhipster/jhipster-devbox/issues/54)
apt-get remove -y light-locker --purge

# change the default wallpaper
#wget https://jhipster.github.io/images/wallpaper-004-2560x1440.png -O /usr/share/xfce4/backdrops/jhipster-wallpaper.png
wget https://raw.githubusercontent.com/jhipster/jhipster-devbox/master/images/jhipster-wallpaper.png -O /usr/share/xfce4/backdrops/jhipster-wallpaper.png
sed -i -e 's/xubuntu-wallpaper.png/jhipster-wallpaper.png/' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

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

# install cqlsh
apt-get install -y python-pip
pip install cqlsh

# install mongo client
apt-get install -y mongodb-clients

# install Heroku toolbelt
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# install Cloud Foundry client
cd /opt && curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx
ln -s /opt/cf /usr/bin/cf

# install the AWS tools
pip install awscli
npm install -g aws-sdk progress node-uuid

#install Guake
apt-get install -y guake
cp /usr/share/applications/guake.desktop /etc/xdg/autostart/

# install zsh
apt-get install -y zsh

# install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc
chsh -s /bin/zsh
echo 'SHELL=/bin/zsh' >> /etc/environment

# install jhipster-oh-my-zsh-plugin
git clone https://github.com/jhipster/jhipster-oh-my-zsh-plugin.git /home/vagrant/.oh-my-zsh/custom/plugins/jhipster
sed -i -e "s/plugins=(git)/plugins=(git docker docker-compose jhipster)/g" /home/vagrant/.zshrc

# change user to vagrant
chown -R vagrant:vagrant /home/vagrant/.zshrc /home/vagrant/.oh-my-zsh

# install Visual Studio Code
su -c 'umake ide visual-studio-code /home/vagrant/.local/share/umake/ide/visual-studio-code --accept-license' vagrant

# fix links (see https://github.com/ubuntu/ubuntu-make/issues/343)
sed -i -e 's/visual-studio-code\/code/visual-studio-code\/bin\/code/' /home/vagrant/.local/share/applications/visual-studio-code.desktop

# disable GPU (see https://code.visualstudio.com/docs/supporting/faq#_vs-code-main-window-is-blank)
sed -i -e 's/"$CLI" "$@"/"$CLI" "--disable-gpu" "$@"/' /home/vagrant/.local/share/umake/ide/visual-studio-code/bin/code

# install useful extensions
ln -sf /home/vagrant/.local/share/umake/ide/visual-studio-code/bin/code /usr/local/bin/code
su -c 'code --install-extension redhat.java' vagrant
su -c 'code --install-extension johnpapa.Angular1' vagrant
su -c 'code --install-extension johnpapa.Angular2' vagrant
su -c 'code --install-extension msjsdiag.debugger-for-chrome' vagrant
su -c 'code --install-extension dbaeumer.vscode-eslint' vagrant
su -c 'code --install-extension EditorConfig.EditorConfig' vagrant

#install IDEA community edition
su -c 'umake ide idea /home/vagrant/.local/share/umake/ide/idea' vagrant

# increase Inotify limit (see https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit)
echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/60-inotify.conf
sysctl -p --system

# install Docker
curl -sL https://get.docker.io/ | sh

# install docker compose
curl -L https://github.com/docker/compose/releases/download/1.10.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# configure docker group (docker commands can be launched without sudo)
usermod -aG docker vagrant

# clean the box
apt-get -y autoclean
apt-get -y clean
apt-get -y autoremove
dd if=/dev/zero of=/EMPTY bs=1M > /dev/null 2>&1
rm -f /EMPTY
