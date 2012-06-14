# manifests/init.pp - manage onak stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3

class onak(
  $keyserver_host = '',
  $nagios_keyid = false,
  $nagios_first_keyline = false,
  $manage_shorewall = false,
  $manage_nagios = false
) {
  case $::operatingsystem {
    default: { include onak::base }
  }

  if $manage_shorewall {
    include shorewall::rules::keyserver
  }
  if $manage_nagios {
    onak::nagios{$onak::keyserver_host:
      keyid => $onak::nagios_keyid,
      first_keyline => $onak::nagios_first_keyline,
    }
  }
}
