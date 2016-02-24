# == Class: druid::middle_manager
#
# Manage the Druid Middle Manager service.
#
# === Parameters
#
# [*service*]
#   Name of the Druid Middle Manager service
#
# [*host*]
#   Host IP address for the Middle Manager daemon
#
# [*port*]
#   The Middle Manager port
#
# [*config*]
#   Hash configuration of the daemon
#
# [*java_opts*]
#   Array for optional parameters for Java
#
# === Examples
#
#  class { 'druid::middle_manager': }
#

class druid::middle_manager (
  $service   = 'middleManager',
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

  druid::service { 'middle_manager':
    config_content => template('druid/service.runtime.properties.erb'),
    init_content   => template('druid/druid.init.erb'),
    java_opts      => $java_opts,
  }

}

