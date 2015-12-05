# JHipster official "development box"

## Introduction

This is a [Vagrant](https://www.vagrantup.com/) configuration to set up a complete, virtualized development environment for JHipster users.

## Usage

The JHipster "development box" is a complete development environment for JHipster users.

It requires to have [Vagrant](https://www.vagrantup.com/) installed on your machine.

It is fully based on Open Source software, most importantly:

- Ubuntu
- Spring Tool Suite
- Chromium Web browser

## Setup

The "Quick setup" provides a pre-build Virtual Machine, and the "Manual setup" let you build your Virtual Machine yourself. We recommend you use the "Quick setup" if you don't know which option to choose.

### Quick setup

Pre-built distributions of this "development box" are available on [Atlas](https://atlas.hashicorp.com/jhipster).

To install the latest distribution, just run:

`vagrant init jhipster/jhipster-devbox; vagrant up --provider virtualbox`

You can then tune your installation, by following the next sections on customizing and configuring your "development box".

### Manual setup

This generates a new "development box" directly from this repository.

- Clone this repository: `git clone https://github.com/jhipster/jhipster-devbox.git`
- Run `vagrant up`

## Customize your box

This is very important! Modify your system properties, depending on your host's hardware. We recommend, at least:

- 4 CPUs
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
  - Spring Tool Suite is installed in the `/opt/sts-bundle/` directory
- Configure your MySQL database
  - Default password for the `root` user is `vagrant`
  - MySQL workbench is installed by default
  - If you want to use MySQL with JHipster, don't forget to edit your `application-dev.yml` and `application-prod.yml` files
- Configure you browser
  - Firefox is installed
  - Chromium, which is the Open-Source version of Google Chrome, is also installed
- Other available tools
  - [Guake](http://guake-project.org/) is installed, hit "F12" to have your terminal
  - The [Atom](https://atom.io/) text editor is installed
- Generate your application
  - Run `yo jhipster` and use JHipster normally
- Use the JHipster tools
  - Running `mvn` will run your JHipster application on port `8080`. As this port is forwarded to your host, you can also use `http://localhost:8080` on your host machine
  - Running `grunt` will launch your AngularJS front-end with BrowserSync on port `3000`: it is also forwarded to your host, so you can also use `http://localhost:3000` on your host machine
