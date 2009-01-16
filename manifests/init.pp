# manifests/init.pp - manage onak stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3

class onak {
    case $operatingsystem {
        default: { include onak::base }
    }
}

class onak::base {
    package{'onak':
        ensure => installed,
    }

    file{'/etc/onak.conf':
        source => [ "puppet://$server/files/onak/${fqdn}/onak.conf",
                    "puppet://$server/files/onak/onak.conf",
                    "puppet://$server/onak/onak.conf" ],
        require => Package['onak'],
        notify => Service['Package'],
        owner => root, group => 0, mode => 0644;
    }

    service{onak:
        ensure => running,
        enable => true,
        hasstatus => true, 
        require => Package[onak],
    }

}
