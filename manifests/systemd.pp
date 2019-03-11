class thumbor::systemd {
  $lastport = $thumbor::ports[-1]
  if $::service_provider == 'systemd'{
    exec { "Reload systemd thumbor" :
      command => '/bin/systemctl daemon-reload',
      require => Exec["Enable Thumbor systemd ${lastport}"]
    }
    exec { "Reload rsyslog thumbor" :
      command => '/bin/systemctl restart rsyslog',
      require => Exec["Enable Thumbor systemd ${lastport}"]
    }
    $thumbor::ports.each |$inst| {
      exec { "Enable Thumbor systemd ${inst}" :
        command => "/bin/systemctl enable thumbor-${inst}",
        onlyif  => "/bin/systemctl is-enabled thumbor-${inst} | /bin/grep 'disabled'",
      }
      exec { "start Thumbor systemd ${inst}" :
        command => "/bin/systemctl restart thumbor-${inst}",
        require => Exec["Reload systemd thumbor"]
      }
    }
  }
  else {
    fail("require systemd")
  }
}