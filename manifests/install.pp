# == Class druid::install
#
# This class is called from druid
#
class druid::install {

  if $druid::install_java {
    include apt
    if $druid::java_ppa {
      apt::ppa { $druid::java_ppa:
        package_manage => true,
        before         => Package['java'],
        notify         => Class['apt::update'],
      }
    }
    class { 'java':
      package => $druid::java_package,
    }
  }

  if $druid::install_method == 'tarball' {
    include 'archive'
    archive { "/usr/src/imply-${druid::imply_version}.tar.gz":
      source       => "http://static.imply.io/release/imply-${druid::imply_version}.tar.gz",
      extract      => true,
      extract_path => '/opt',
    } ->
    file { "${druid::install_dir}/${druid::install_link}":
      ensure => 'link',
      target => "${druid::install_dir}/imply-${druid::imply_version}",
    }
  } else {
    fail("Install method is not supported : ${druid::install_method}")
  }
}
