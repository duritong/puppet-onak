# manifests/init.pp - manage onak stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3

class onak {
  case $operatingsystem {
    default: { include onak::base }
  }

  if $use_shorewall {
    include shorewall::rules::keyserver
  }
  if $use_nagios {
    case $onak_keyserver_host { '': { fail("you need to set \$onak_keyserver_host on $fqdn to get nagios tests working") } }
    case $onak_nagios_first_keyline { '': { fail("you need to set \$onak_nagios_first_keyline on $fqdn to get nagios tests working") } }
    case $onak_nagios_keyid { '': { fail("you need to set \$onak_nagios_keyid on $fqdn to get nagios tests working") } }

    onak::nagios{$onak_keyserver_host:
      keyid => $onak_nagios_keyid,
      first_keyline => $onak_nagios_first_keyline,
    }
  }
}
