class onak::logrotate {
  include ::logrotate

  file{'/etc/logrotate.d/onak':
    content => "/var/log/onak.log {
  daily
  missingok
  rotate 7
  compress
  copytruncate
  notifempty
  create 640 apache apache
}\n",
    require => Package['logrotate'],
    owner   => 'root',
    group   => 0,
    mode    => '0644';
  }
}
