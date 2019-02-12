class thumbor::install::pip {
  package { ['libwebp-dev',
    'python-statsd',
    'python-crypto',
    'libjpeg-dev',
    'libpng-dev',
    'libtiff5-dev',
    'python-numpy',
    'python-opencv',
    'libmemcached-dev',
    'libcurl4-openssl-dev'
  ]: }
  -> package { 'colour':
    provider => 'pip'
  }
  -> package { 'thumbor':
    provider => 'pip',
    ensure => '6.7.0'
  }
  -> package { 'tc_redis':
    provider => 'pip',
  }
  -> package { 'tc_mongodb':
    provider => 'pip',
    ensure => '5.1.0'
  }
  -> package { 'https://github.com/timich/thumbor_mongodb/archive/master.zip':
    provider => 'pip',
  }
  
  
  https://github.com/timich/thumbor_mongodb/archive/master.zip
  
  -> package { 'opencv-engine':
    provider => 'pip',
  }
  #if $::service_provider == 'systemd'{
  thumbor::systemd{ thumbor: }
  exec { "Reload systemd  thumbor" :
    command => '/bin/systemctl daemon-reload',
    before => Exec["Enable Thumbor systemd"]
  }
  exec { "Enable Thumbor systemd" :
    command => "/bin/systemctl enable thumbor",
    onlyif  => "/bin/systemctl is-enabled thumbor | /bin/grep 'disabled'",
    #require => Class['thumbor::systemd'],
    before  => Service["thumbor"],
  }
  # }
  group { 'thumbor':
    system => true,
    ensure => present
  }
  user { 'thumbor':
    system => true,
    gid => 'thumbor',
    home => '/var/lib/thumbor',
    require => Group['thumbor']
  }
  file { '/var/lib/thumbor':
    ensure => directory,
    owner => 'thumbor',
    group => 'thumbor',
    mode => '0755'
  }
}
