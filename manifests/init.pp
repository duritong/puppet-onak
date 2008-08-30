# modules/onak/manifests/init.pp - manage onak stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3

# modules_dir { "onak": }

class onak {
    case $operatingsystem {
        default: { include onak::base }
    }
}

class onak::base {
    package{'onak':
        ensure => installed,
    }

#    service{onak:
#        ensure => running,
#        enable => true,
#        #hasstatus => true, #fixme!
#        require => Package[onak],
#    }
}
