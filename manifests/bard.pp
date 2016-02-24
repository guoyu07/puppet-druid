# == Class: druid::bard
#
# Manager Bard
#
# === Parameters
#
# [*config_dir*]
#   Configuration directory of Bard
#
# [*port*]
#   Port of Bard
#
# [*broker_host*]
#   Address of the Broker host
#
# [*enable_stdout_log*]
#
# [*enable_file_log*]
#
# [*log_dir*]
#
# [*max_workers*]
#
# [*use_segment_metadata*]
#
# [*source_list_refresh_interval*]
#
# [*source_list_refresh_onload*]
#
# [*install_nodejs*]
#
# === Examples
#
#  class { 'druid::bard': }
#

class druid::bard (
  $config_dir                   = '/opt/imply/conf/bard',
  $port                         = 9095,
  $broker_host                  = 'localhost:8082',
  $enable_stdout_log            = true,
  $enable_file_log              = true,
  $log_dir                      = '/var/log/bard',
  $max_workers                  = 0,
  $use_segment_metadata         = false,
  $source_list_refresh_interval = 0,
  $source_list_refresh_onLoad   = false,
  $install_nodejs               = false,
){
  require '::druid'

  validate_string(
    $broker_host,
    $log_dir
  )
  validate_integer([
    $port,
    $max_workers,
    $source_list_refresh_interval
  ])
  validate_bool(
    $enable_stdout_log,
    $enable_file_log,
    $use_segment_metadata,
    $source_list_refresh_onLoad,
    $install_nodejs
  )

  Class['druid'] ->
  class { 'druid::bard::install': } ->
  class { 'druid::bard::config':  } ~>
  class { 'druid::bard::service': } ->
  Class['druid::bard']

}
