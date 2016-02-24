# == Class: druid::historical
#
# Manage the Druid Historical service.
#
# === Parameters
#
# [*service*]
#   Name of the Druid Historical service
#
# [*host*]
#   Host IP address for the Historical daemon
#
# [*port*]
#   The Historical port
#
# [*config*]
#   Hash configuration of the daemon
#
# [*java_opts*]
#   Array for optional parameters for Java
#
# === Examples
#
#  class { 'druid::historical': }
#

class druid::historical (
  $service   = 'historical',
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

  druid::service { 'historical':
    config_content => template('druid/service.runtime.properties.erb'),
    init_content   => template('druid/druid.init.erb'),
    java_opts      => $java_opts,
  }

}

