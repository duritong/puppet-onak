define onak::nagios(
  $ensure = 'present',
  $keyid,
  $first_keyline,
  $protocol = 'both',
  $max_check_attempts = ''
){
  nagios::service{
    "hkp_${name}":
      ensure => $ensure ? {
        'present' => $protocol ? {
          'hkps' => 'absent',
          default => 'present',
        },
        default => $ensure,
      },
      max_check_attempts => $max_check_attempts,
      check_command => "check_http_port_url_content!${name}!11371!'/pks/lookup?op=get&search=${keyid}'!${first_keyline}";
    "hkps_${name}":
      ensure => $ensure ? {
        'present' => $protocol ? {
          'hkp' => 'absent',
          default => 'present',
        },
        default => $ensure,
      },
      max_check_attempts => $max_check_attempts,
      check_command => "check_https_port_url_content!${name}!11372!'/pks/lookup?op=get&search=${keyid}'!${first_keyline}";	      
  }
}
