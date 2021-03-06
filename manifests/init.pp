# = Class: thumbor
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
class thumbor (
$security_key='MY_SECURE_KEY_207',
$ports=['8888'],
$ip='0.0.0.0',
$path_log='/var/log/thumbor',
$config = {},
$conffile = '/dev/null',
$install_method = 'pip'
) {
  ## Modules
  include thumbor::config
  include thumbor::systemd
  ## Ordering
  Class['thumbor::config']
  ~> Class['thumbor::systemd']
  if $install_method == 'apt' {
    include thumbor::repo
    include thumbor::install::apt
    Class['thumbor::repo'] -> Class['thumbor::install::apt'] -> Class['thumbor::config']
  } elsif $install_method == 'pip' {
    include thumbor::install::pip
    Class['thumbor::install::pip'] -> Class['thumbor::config']
  } elsif $install_method == 'pip3' {
    include thumbor::install::pip3
    Class['thumbor::install::pip3'] -> Class['thumbor::config']
  } else {
    fail("install_method must be 'apt' or 'pip'")
  }
}
