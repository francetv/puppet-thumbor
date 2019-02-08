define thumbor::systemd {
  $systemd_setting = {
    'Unit' => {
      'Description'   => 'thumbor daemon',
      'After'         => 'network.target',
    },
    'Service' => {
      'ExecStart'   => "/usr/local/bin/thumbor -c /etc/thumbor.conf -k /etc/thumbor.key",
      'User' => 'thumbor',
      'Group' => 'thumbor',
    },
    'Install' => {
      'WantedBy'   => 'multi-user.target',
    }
  }
  $defaults = { 'path' => "/lib/systemd/system/thumbor.service" }
  create_ini_settings($systemd_setting, $defaults)
}