# == Class: druid::coordinator
#
# Manage the Druid Coordinator service.
#
# === Parameters
#
# [*service*]
#   Name of the Druid Coordinator service
#
# [*host*]
#   Host IP address for the Coordinator daemon
#
# [*port*]
#   The Coordinator port
#
# [*config*]
#   Hash configuration of the daemon
#
# [*java_opts*]
#   Array for optional parameters for Java
#
# === Examples
#
#  class { 'druid::coordinator': }
#

class druid::coordinator (
  $service   = 'coordinator',
  $host      = 'localhost',
  $port      = 8083,
  $java_opts = [],
  $config    = {},
){
  require druid

  validate_string(
    $service,
    $host
  )
  validate_integer($port)
  validate_hash($config)
  validate_array($java_opts)

  druid::service { 'coordinator':
    config_content => template('druid/service.runtime.properties.erb'),
    init_content   => template('druid/druid.init.erb'),
    java_opts      => $java_opts,
  }

}

