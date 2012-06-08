# manifests/init.pp - manage onak stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3

class onak(
  $keyserver_host = hiera('onak_keyserver_host',''),
  $nagios_keyid = hiera('onak_nagios_keyid',false),
  $nagios_first_keyline = hiera('onak_nagios_first_keyline',false)
) {
  case $::operatingsystem {
    default: { include onak::base }
  }

  if hiera('use_shorewall',false) {
    include shorewall::rules::keyserver
  }
  if hiera('use_nagios',false) {
    onak::nagios{$onak::keyserver_host:
      keyid => $onak::nagios_keyid,
      first_keyline => $onak::nagios_first_keyline,
    }
  }
}
