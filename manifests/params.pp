# == Class: thumbor::params
#
class thumbor::params {
  case $::osfamily {
    'Debian': {
      $security_key='MY_SECURE_KEY'
      $port='8888'
      $ip='0.0.0.0'
      $path_log='/var/log/thumbor'
      $config = {}
      $conffile = '/dev/null'
#      if versioncmp($::operatingsystemrelease, '10') >= 0 {
#        $install_method = 'pip3'
#      } else {
#        $install_method = 'pip'
#      }
#    }
    default: {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
    }
  }
}
