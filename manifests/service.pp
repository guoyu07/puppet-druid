# == Define Type: druid::service
#
# Generic setup for Druic service related resources.
#
# === Parameters
#
# [*service_name*]
#   Name the service is known by (e.g historical, broker, realtime, ...).
#
#   Default value: `$name`
#
# [*config_content*]
#   Required content for the service properties file.
#

define druid::service (
  $config_content,
  $init_content,
  $java_opts,
  $service_name = $title,
) {
  require druid

  validate_string(
    $config_content,
    $service_name
  )

  validate_array($java_opts)

  case $druid::enable_service {
    true: {
      $ensure_service = 'running'
      $notify_service = Service["druid-${service_name}"]
    }
    default: {
      $ensure_service = 'stopped'
      $notify_service = undef
    }
  }

  file { "${druid::config_dir}/${service_name}":
    ensure  => directory,
    require => Class['druid'],
  }

  file { "${druid::config_dir}/${service_name}/runtime.properties":
    ensure  => file,
    content => $config_content,
    notify  => $notify_service,
    require => File["${druid::config_dir}/${service_name}"],
  }

  file { "/etc/init.d/druid-${service_name}":
    ensure  => file,
    mode    => '0755',
    content => $init_content
  }
  service { "druid-${service_name}":
    ensure  => $ensure_service,
    enable  => true,
    require => File["/etc/init.d/druid-${service_name}"]
  }
}

