class onak::base {
  package{'onak':
    ensure => installed,
  }

  file{'/etc/onak.conf':
    source => [ "puppet:///modules/site_onak/${::fqdn}/onak.conf",
                "puppet:///modules/site_onak/onak.conf",
                "puppet:///modules/onak/onak.conf" ],
    require => Package['onak'],
    notify => Service['onak'],
    owner => root, group => 0, mode => 0644;
  }

  service{onak:
    ensure => running,
    enable => true,
    hasstatus => true,
    require => Package[onak],
  }

  include onak::logrotate
}
