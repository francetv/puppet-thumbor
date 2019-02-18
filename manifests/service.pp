# = Class: thumbor::service
#
# This module manages thumbor
#
# == Parameters:
#
# == Actions:
#
# == Requires:
#
# == Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
case $thumbor_service_provider {
  'systemd': {
    $thumbor::ports.each |String $inst| {
      file { "/etc/systemd/system/thumbor-${inst}-service.cfg":
      #ensure  => $newrelic_php_service_ensure,
      content => template('thumbor/thumbor.service.erb'),
      }
    }~>
    exec { 'thumbor-systemd-reload':
      command     => 'systemctl daemon-reload',
      path        => [ '/usr/bin', '/bin', '/usr/sbin', '/usr/local/bin/' ],
      refreshonly => true,
    }
  }
  default: {}
}
class thumbor::service {
  service {"thumbor-${inst}":
    require => File["/etc/thumbor.conf",
    '/etc/thumbor.key',
    '/etc/default/thumbor'],
    ensure  => running,
    enable  => true,
    subscribe => File["/etc/thumbor.conf",
    '/etc/thumbor.key',
    '/etc/default/thumbor'],
  }
}
