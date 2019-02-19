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
    'libcurl4-openssl-dev',
    'libjpeg-turbo-progs',
    'pngquant'    
  ]: }
  -> package { 'colour':
    provider => 'pip'
  }
  -> package { 'thumbor':
    provider => 'pip',
    ensure => '6.7.0'
  }
  -> package { 'thumbor-plugins':
    provider => 'pip'
  }  
  -> package { 'remotecv':
    provider => 'pip',
  }
  -> package { 'tc_redis':
    provider => 'pip',
  }
  -> package { 'https://github.com/francetv/mongodb/archive/master.zip':
    provider => 'pip'
  }
  -> package { 'https://github.com/francetv/thumbor_mongodb/archive/master.zip':
    provider => 'pip'
  }
  
  -> package { 'opencv-engine':
    provider => 'pip',
  }
  #if $::service_provider == 'systemd'{
  thumbor::systemd{ thumbor: }
  exec { "Reload systemd  thumbor" :
    command => '/bin/systemctl daemon-reload',
    before => Exec["Enable Thumbor systemd"]
  }
  $thumbor::ports.each |$inst| {
  exec { "Enable Thumbor systemd" :    
    #$thumbor::ports.each |String $inst| {
    command => "/bin/systemctl enable thumbor-${inst}",
    onlyif  => "/bin/systemctl is-enabled thumbor-${inst} | /bin/grep 'disabled'",
    #require => Class['thumbor::systemd'],
    before  => Service["thumbor-${inst}"],    
    }
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
