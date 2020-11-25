class thumbor::install::pip {
  package { ['libwebp-dev',
    'python-statsd',
    'python-crypto',
    'libjpeg-dev',
    'libopencv-dev',
    'libpng-dev',
    'libtiff5-dev',
    'python-numpy',
    'python-opencv',
    'libmemcached-dev',
    'libcurl4-openssl-dev',
    'libjpeg-turbo-progs',
    'gifsicle',
    'pngquant',
    'ffmpeg'
  ]: }
  -> package { 'requests':
    provider => 'pip'
  }
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
    provider => 'pip'
  }
  -> package { 'tc_prometheus':
    provider => 'pip'
  }
  -> package { 'configparser':
    provider => 'pip'
  }
  -> package { 'https://github.com/francetv/thumbor_mongodb_storage/archive/v5.3.0.tar.gz':
    provider => 'pip'
  }
  -> package { 'https://github.com/francetv/thumbor_mongodb_loader/archive/v1.2.5.tar.gz':
    provider => 'pip'
  }
  -> package { 'https://github.com/francetv/thumbor_file_loader_pic/archive/v1.0.1.tar.gz':
    provider => 'pip'
  }
  -> package { 'https://github.com/francetv/thumbor_mongodb_storage_webp/archive/v6.1.0.tar.gz':
    provider => 'pip'
  }
  -> package { 'https://github.com/francetv/thumbor_url_signer/archive/v1.0.1.tar.gz':
    provider => 'pip'
  }
  -> package { 'https://github.com/francetv/thumbor_ftvnum_libs/archive/0.1.0.tar.gz':
    provider => 'pip'
  } 
  -> package { 'opencv-engine':
    provider => 'pip'
  }
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
