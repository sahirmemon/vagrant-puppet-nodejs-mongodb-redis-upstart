class init {

	/**
	 * Setup
	 */

	file { "/etc/hosts":
		source => "/vagrant/setup/vagrant/root/hosts",
		owner => "root",
		group => "root",
		before => Exec["apt-get-update-initial"]
	}

    file { '/etc/default/locale':
      content => "LANG=\"en_US.UTF-8\"\nLC_ALL=\"en_US.UTF-8\"\n"
    }

	exec { "apt-get-update-initial":
		command => "sudo apt-get update",
        path => ["/bin", "/usr/bin"]
	}

	package { [ "python-software-properties" ] :
		ensure => present,
		require => Exec["apt-get-update-initial"]
	}

	exec { "prepare-redis-install":
		command => "/usr/bin/add-apt-repository -y ppa:rwky/redis",
		require => Package["python-software-properties"]
	}

	exec { "apt-get-update":
		command => "sudo apt-get update",
        path => ["/bin", "/usr/bin"],
		require => Exec["prepare-redis-install"]
	}

	package { [
			"build-essential", "libcurl3", "libfontconfig1",
			"curl", "git-core", "redis-server", "vim", "htop", "g++", "python",
            "vim-common", "make", "wget", "tar", "mc"
		] :
		ensure => present,
		require => Exec["apt-get-update"]
	}

	/**
	 * MongoDB
	 */
    
    class {'::mongodb::globals':
        manage_package_repo => true,
        bind_ip             => ["127.0.0.1"]
    }
    
    class {'::mongodb::server':
        port    => 27017,
        verbose => true,
        ensure  => "present"
    }
    
    class {'::mongodb::client': }
  

    /** 
     * NodeJs
     */
    
    class { 'nodejs':
        version => 'stable',
        make_install => false,
    }
 
	/**
	 * Redis
	 */
     
	service { "redis-server":
		ensure => running,
        enable => true,
        hasrestart => true,
		require => Package["redis-server", "python-software-properties"],
	}

	/**
	 * Directories
	 */

	file { "/vagrant/app/logs":
		ensure => "directory",
	}

	file { "/vagrant/app/cache":
		ensure => "directory",
	}

	file { "/vagrant/logs":
		ensure => "directory",
	}
	
	/**
	 * Upstart
	 */
	 file { "/etc/init/app_install.conf":
        ensure  => file,
        source  => "/vagrant/setup/vagrant/puppet/files/app_install.conf",
        require => Class["Nodejs"],
    }

    service { 'app_install':
        ensure => running,
        provider => 'upstart',
        require => File['/etc/init/app_install.conf'],
    }
    
	file { "/etc/init/app.conf":
        ensure  => file,
        source  => "/vagrant/setup/vagrant/puppet/files/app.conf",
        require => Class["Nodejs"],
    }

    service { 'app':
        ensure => running,
        provider => 'upstart',
        require => File['/etc/init/app.conf'],
    }
}

include init