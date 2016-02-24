# == Class: druid
#
# This module manage Druid based on the Imply Analytics Platform version.
# It is able to manage all the Druid daemons and Bard.
#
# Documentation : http://imply.io
#
# === Parameters
#
# [*imply_version*]
#   Version of the Imply stack to deploy
#   Defaults : 1.0.0
#
# [*install_method*]
#   For now we only support deployment from tarball
#   Defaults : tarball
#
# [*install_dir*]
#   Target directory to deploy the Imply tarball
#   Defaults : /opt
#
# [*install_link*]
#   Installation link name
#   Defaults : imply
#
# [*install_java*]
#   If true, the module will install Java using puppetlabs/java
#   Defaults : true
#
# [*config_dir*]
#   Main configuration directory for Druid
#   Defaults : /opt/imply/conf/druid
#
# [*dist_dir*]
#   Distribution directory of Druid
#   Defaults : /opt/imply/dist/druid
#
# [*user*]
#   Druid user
#   Defaults : druid
#
# [*group*]
#   Druid user group
#   Defaults : druid
#
# [*enable_service*]
#
#   Defaults : false
#
# [*java_home*]
#   Java home directory
#   Defaults : /opt/java
#
# [*java_classpath*]
#   Distribution directory of Druid
#   Defaults : /opt/imply/dist/druid
#
# [*java_classpath_extensions*]
#   Array of Java extensions libraries
#   Defaults : undef
#
# [*log_dir*]
#   Directory to store logs
#   Defaults : /var/log/druid
#
# [*zk_host*]
#   Zookeeper host string.
#   Example : zk01:2181,zk02:2181
#   Defaults : undef
#
# [*zk_path*]
#   Zookeeper Znode path
#   Defaults : /druid
#
# [*common_extentions*]
#   Druid's external dependencies configuration
#   See : http://druid.io/docs/latest/configuration/#extensions
#
# [*common_properties_metadata*]
#   Druid's metadata storage configuration
#   See : http://druid.io/docs/latest/configuration/#metadata-storage
#
# [*common_properties_deepstorage*]
#   Druid's deep storage configuration
#   See : http://druid.io/docs/latest/configuration/#deep-storage
#
# [*common_properties_indexer*]
#   Druid's indexer service configuration
#   See : http://druid.io/docs/latest/configuration/indexing-service.html
#
# [*common_properties_monitoring*]
#   Druid's monitoring (metrics) configuration
#   See : http://druid.io/docs/latest/configuration/#enabling-metrics
#
# [*common_selectors_indexing_service*]
#   Druid's indexing service name
#   Default : overlord
#   See : http://druid.io/docs/latest/configuration/#indexing-service-discovery
#
# === Examples
#
#   class { 'druid': }
#

class druid (
  $imply_version             = '1.0.0',
  $install_method            = 'tarball',
  $install_dir               = '/opt',
  $install_link              = 'imply',
  $install_java              = false,
  $java_ppa                  = 'ppa:openjdk-r/ppa',
  $java_package              = 'openjdk-8-jdk',
  $java_home                 = '/usr/lib/jvm/java-8-openjdk-amd64',
  $config_dir                = '/opt/imply/conf/druid',
  $dist_dir                  = '/opt/imply/dist/druid',
  $user                      = 'druid',
  $group                     = 'druid',
  $enable_service            = true,
  $java_classpath            = '/opt/imply/dist/druid/lib/*',
  $java_classpath_extensions = {},
  $log_dir                   = '/var/log/druid',

  # Zookeeper configuration
  $zk_host = undef,
  $zk_path = '/druid',

  # Common configuration
  $common_extensions = {},
  $common_properties_metadata    = {},
  $common_properties_deepstorage = {},
  $common_properties_indexer     = {},
  $common_properties_monitoring  = {},
  $common_selectors_indexing_service = 'overlord',

) {

  validate_string(
    $imply_version,
    $install_method,
    $install_dir,
    $install_link,
    $config_dir,
    $dist_dir,
    $user,
    $group,
    $common_selectors_indexing_service,
    $zk_host,
    $zk_path,
    $java_home,
    $java_classpath,
    $java_package,
    $java_ppa
  )
  validate_bool($enable_service)
  validate_hash(
    $common_properties_metadata,
    $common_properties_deepstorage,
    $common_properties_indexer,
    $common_properties_monitoring)

  contain 'druid::install'
  contain 'druid::config'

  Class['druid::install'] ->
  Class['druid::config']
}
