class thumbor::install::pip3 {
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
    provider => 'pip3'
  }
  -> package { 'colour':
    provider => 'pip3'
  }
  -> package { 'thumbor':
    provider => 'pip3',
    ensure => '7.0.0a5'
  }
  -> package { 'thumbor-plugins':
    provider => 'pip3'
  }
  -> package { 'remotecv':
    provider => 'pip3'
  }
  -> package { 'configparser':
    provider => 'pip3'
  }
  -> package { 'https://github.com/francetv/thumbor_ftvnum_libs/archive/p3.zip':
    provider => 'pip3'
  } 
  -> package { 'opencv-engine':
    provider => 'pip3'
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
