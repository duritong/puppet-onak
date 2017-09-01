# a simple check for nagios
define onak::nagios(
  $keyid,
  $first_keyline,
  $ensure             = 'present',
  $protocol           = 'both',
  $max_check_attempts = undef
){

  if !keyid and !$first_keyline {
    fail("You need to pass \$first_keyline and \$keyid")
  }

  $hkp_ensure = $ensure ? {
    'present' => $protocol ? {
      'hkps'  => 'absent',
      default => 'present',
    },
    default => $ensure,
  }
  $hkps_ensure = $ensure ? {
    'present' => $protocol ? {
      'hkp'   => 'absent',
      default => 'present',
    },
    default => $ensure,
  }
  nagios::service{
    "hkp_${name}":
      ensure             => $hkp_ensure,
      max_check_attempts => $max_check_attempts,
      check_command      => "check_http_port_url_content!${name}!11371!'/pks/lookup?op=get&search=${keyid}'!${first_keyline}";
    "hkps_${name}":
      ensure             => $hkps_ensure,
      max_check_attempts => $max_check_attempts,
      check_command      => "check_https_port_url_content!${name}!11372!'/pks/lookup?op=get&search=${keyid}'!${first_keyline}";
  }
}
