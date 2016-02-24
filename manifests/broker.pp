# == Class: druid::broker
#
# Manage the Druid Broker service.
#
# === Parameters
#
# [*service*]
#   Name of the Druid Broker service
#
# [*host*]
#   Host IP address for the Broker daemon
#
# [*port*]
#   The Broker port
#
# [*config*]
#   Hash configuration of the daemon
#
# [*java_opts*]
#   Array for optional parameters for Java
#
# === Examples
#
#  class { 'druid::broker': }
#

class druid::broker (
  $service   = 'broker',
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

  druid::service { 'broker':
    config_content => template('druid/service.runtime.properties.erb'),
    init_content   => template('druid/druid.init.erb'),
    java_opts      => $java_opts,
  }

}

