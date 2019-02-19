class thumbor::systemd {
  if $::service_provider == 'systemd'{
    exec { "Reload systemd  thumbor" :
      command => '/bin/systemctl daemon-reload',
      before => Exec["Enable Thumbor systemd"]
    }
    exec { "Enable Thumbor systemd" :
      $thumbor::ports.each |$inst| {
        command => "/bin/systemctl enable thumbor-${inst]",
        onlyif  => "/bin/systemctl is-enabled thumbor-${inst} | /bin/grep 'disabled'",
        #require => Class['thumbor::systemd'],
        #before  => Service["thumbor"],
      }
    }
  }
  else {
    fail("require systemd")
  }
}