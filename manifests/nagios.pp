define onak::nagios(
  $keyid,
  $first_keyline
){
  nagios::service{
    "hkp_${name}":
      check_command => "check_http_port_url_content!${name}!11371!/pks/lookup?op=get&search=${keyid}!${first_keyline}";
    "hkps_${name}":
      check_command => "check_https_port_url_content!${name}!11372!/pks/lookup?op=get&search=${keyid}!${first_keyline}";
  }
}
