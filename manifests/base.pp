# manage onak
class onak::base {
  package{'onak':
    ensure => installed,
  }

  if versioncmp($facts['os']['release']['major'],'6') > 0 {
    # tbd
  } else {
    file{'/etc/onak.conf':
      source  => [ "puppet:///modules/site_onak/${::fqdn}/onak.conf",
                  'puppet:///modules/site_onak/onak.conf',
                  'puppet:///modules/onak/onak.conf' ],
      require => Package['onak'],
      notify  => Service['onak'],
      owner   => 'root',
      group   => 0,
      mode    => '0644';
    }
    include onak::logrotate
  }

  service{'onak':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['onak'],
  }

  if $facts['selinux'] {
    package {
      'onak-selinux' :
        ensure  => installed,
        require => Package['onak'],
        before  => Service['onak'],
    }
  }
}
