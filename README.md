# A template for: vagrant-puppet-nodejs-mongodb-redis-upstart
A template for a NodeJS app with MongoDB using Redis powered by Vagrant and Puppet using Upstart.

### Overview
I created this template as a starting point for the redesign of my [Write Often](writeoften.com) app. Using this template I am creating a NodeJS powered API of Write Often. There are number possibilites of using this template for more purposes. 

I am using the following technologies in this template:
* **VirtualBox**: Powers the Vagrant VM.
* **Vagrant**: A development environment manager. In this template I am downloading and using Ubuntu Server 14.04 LTS.
* **Puppet**: Manages the install of all softwares and libraries including NodeJS, MongoDB, Redis, and Upstart.
* **NodeJS**
* **MongoDB**
* **Redis**
* **Upstart**

Read below to find out what is required and how to get started.

### Requirements

Download and install the following:

1. VirtualBox: https://www.virtualbox.org/wiki/Downloads
2. Vagrant: http://www.vagrantup.com/downloads.html

### Usage

1. Clone this repo 
2. Open up `Terminal` and navigate to the home of this repo
3. Type in `$ vagrant plugin install vagrant-hostsupdater`
5. Type in `$ vagrant up`
6. Visit your app in the browser at `http://local.myawesomeapp.com`

