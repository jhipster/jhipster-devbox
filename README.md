# Official Vagrant configuration for JHipster

__This is under development, do NOT use it yet__

## Usage

This Vagrantfile generates a complete development environment for developing a JHipster application.

It requires to have [Vagrant](https://www.vagrantup.com/) installed on your machine.

It is fully based on Open Source software, most importantly:

- Ubuntu
- Spring Tool Suite
- Chromium Web browser

## Create a Vagrant box

- Clone this repository: `git clone https://github.com/jhipster/jhipster-devbox.git`
- Run `vagrant up`

## Customize your Vagrant box

Modify your system properties, depending on your host's hardware, we recommend:

- 2 CPUs
- 8 Gb of RAM
- 128 Mb of video RAM

## Configure your new box

Start up the new box:

- Login using the `vagrant` user (not the 'Ubuntu' user which is selected by default)
  - Password is `vagrant`, be careful the default keymap is QWERTY!
  - Before logging in, click on the Ubuntu logo to select the Window environment you want to use
    - We recommend you use `GNOME Flashback (Metacity)`, as it doesn't use 3D effects and will be a lot faster on VirtualBox
- Configure your keyboard, if you are not using an English keyboard, once you have logged in:
    - If you chose `GNOME Flashback (Metacity)`:
      - Go to `Applications > System Tools > System Settings`
      - Select `Text Entry`
      - Use the `+` sign to add your keyboard layout
    - If you kept the default Ubuntu desktop:
      - Click the "EN" icon on the top right of your screen
      - Select `Text Entry Settings...``
      - Use the `+` sign to add your keyboard layout
      - Then select your new keymap by clicking on the "EN" icon again
- Configure your IDE
  - Spring Tool Suite is installed in your `/home/vagrant/applications` directory
- Configure you browser
  - Firefox is installed
  - Chromium, which is the Open-Source version of Google Chrome, is also installed
- Generate your application
  - Run `yo jhipster` and use JHipster normally
- Use the JHipster tools
  - Running `mvn` will run your JHipster application on port `8080`. As this port is forwarded to your host, you can also use `http://localhost:8080` on your host machine
  - Running `grunt` will launch your AngularJS front-end with BrowserSync on port `3000`: it is also forwarded to your host, so you can also use `http://localhost3000` on your host machine

## Roadmap

Have a look at how to support other technologies like:

- Support Postgresql
- Support NoSQL databases like Cassandra, MongoDB
- Support Elasticsearch
- Support for LibSass
- Support CloudFoundry
