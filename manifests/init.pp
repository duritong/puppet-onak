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
}
