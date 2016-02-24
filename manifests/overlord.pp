# == Class: druid::overlord
#
# Manage the Druid Overlord service.
#
# === Parameters
#
# [*service*]
#   Name of the Druid Overlord service
#
# [*host*]
#   Host IP address for the Overlord daemon
#
# [*port*]
#   The Overlord port
#
# [*config*]
#   Hash configuration of the daemon
#
# [*java_opts*]
#   Array for optional parameters for Java
#
# === Examples
#
#  class { 'druid::overlord': }
#

class druid::overlord (
  $service   = 'overlord',
  $host      = 'localhost',
  $port      = 8083,
  $config    = {},
  $java_opts = [],
){
  require druid

  validate_string(
    $service,
    $host
  )
  validate_integer($port)
  validate_hash($config)
  validate_array($java_opts)

  druid::service { 'overlord':
    config_content => template('druid/service.runtime.properties.erb'),
    init_content   => template('druid/druid.init.erb'),
    java_opts      => $java_opts,
  }

}

