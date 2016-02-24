# == Class druid::nodejs
#
# This class is called from druid::bard
#
class druid::nodejs {
  apt::source { 'apt-node_4.x':
    location => 'https://deb.nodesource.com/node_4.x',
    repos    => 'main',
    key      => {
      'id'     => '1655A0AB68576280',
      'server' => 'pgp.mit.edu',
    },
    notify   => Class['apt::update'],
  }

  package { 'nodejs':
    ensure  => latest,
    require => Apt::Source['apt-node_4.x'],
  }
}
