class thumbor::systemd {
  $lastport = $thumbor::ports[-1]
  if $::service_provider == 'systemd'{
    exec { "Reload systemd  thumbor" :
      command => '/bin/systemctl daemon-reload',
      before => Exec["Enable Thumbor systemd ${lastport}"]
    }
    $thumbor::ports.each |$inst| {
      exec { "Enable Thumbor systemd ${inst}" :
        command => "/bin/systemctl enable thumbor-${inst}",
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