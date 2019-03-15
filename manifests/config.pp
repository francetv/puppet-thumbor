# = Class: thumbor::config
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
class thumbor::config {
  $plog = $thumbor::path_log
  file {'/etc/default/thumbor':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    content=> template('thumbor/default.erb'),
  }
  $thumbor::ports.each |$inst| {
    $statp = $inst.to_i +100
    file {"/etc/thumbor-${inst}.conf":
      ensure => present,
      owner  =>'root',
      group  => 'root',
      mode   => '0644',
      content=> template($thumbor::conffile,"thumbor/thumbor.conf.erb")
    }
  }
  file { $thumbor::path_log:
    ensure          => directory,
    owner           => 'root',
    group           => 'adm',
  }
  file { "/etc/thumbor:
    ensure          => directory,
    owner           => 'root',
    group           => 'adm',
  }
  file {"/etc/rsyslog.d/40_thumbor.conf":
    ensure => present,
    owner  =>'root',
    group  => 'root',
    mode   => '0644',
    content=> template($thumbor::conffile,"thumbor/thumbor.rsyslog.erb")
  }
  file {'/etc/thumbor.key':
    ensure => present,
    owner  => 'thumbor',
    group  => 'thumbor',
    mode   => '0600',
    content=> $thumbor::security_key,
  }
  if $::service_provider == 'systemd'{
    $thumbor::ports.each |$inst| {
      file { "/etc/systemd/system/thumbor-${inst}.service":
        content => template('thumbor/thumbor.service.erb')
      }
    }
  }
}
