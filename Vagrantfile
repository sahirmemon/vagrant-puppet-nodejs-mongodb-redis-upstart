# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # For reference: https://docs.vagrantup.com/v2/

  config.vm.box = "ubuntu/trusty64"
  # config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network :forwarded_port, guest: 80, host: 3000
  # config.vm.network :forwarded_port, guest: 443, host: 3001
  config.vm.network :forwarded_port, guest: 27017, host: 27017

  config.vm.network :private_network, ip: "192.168.5.10"
  config.vm.hostname = "local.myawesomeapp.com"
  config.hostsupdater.aliases = [
    "local.myawesomeapp.com"
  ]

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end


  synced_folder_options = {
    :owner => "vagrant",
    :group => "www-data",
    :mount_options => ["dmode=777", "fmode=777"],
    :create => true
  }

  # Set log folder permissions
  config.vm.synced_folder "./logs",          "/vagrant/logs",            synced_folder_options
  config.vm.synced_folder "./app/logs",      "/vagrant/app/logs",        synced_folder_options

  # Set cache folder permissions
  config.vm.synced_folder "./app/cache",      "/vagrant/app/cache",      synced_folder_options


  # Automatically install the librarian plugin
  unless Vagrant.has_plugin?("vagrant-librarian-puppet")
    puts "vagrant-librarian-puppet is not installed."
    puts "Installing now, this may take a couple minutes."
    result = `vagrant plugin install vagrant-librarian-puppet`
    puts result
  end

  config.librarian_puppet.puppetfile_dir = "setup/vagrant/puppet"
  config.librarian_puppet.placeholder_filename = ".PUPPET_PLACEHOLDER"


  config.vm.provision :puppet do |puppet|
    puppet.module_path = "setup/vagrant/puppet/modules"
    puppet.options = "--verbose --debug"
    puppet.manifests_path = "setup/vagrant/puppet"
    puppet.manifest_file  = "default.pp"
  end

  config.vm.provision "shell", run: "always", inline: ""

end
