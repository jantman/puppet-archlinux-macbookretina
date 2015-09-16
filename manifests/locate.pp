# Class: archlinux_macbookretina::locate
#
# Install the mlocate package and run updatedb
#
# Parameters:
#
# Actions:
#   - Install mlocate
#   - Exec updatedb
#
# Requires:
#
# Sample Usage:
#
class archlinux_macbookretina::locate {

  package {'mlocate':
    ensure => present,
    notify => Exec['updatedb'],
  }

  exec {'updatedb':
    refreshonly => true,
    command     => '/usr/bin/updatedb',
    subscribe   => Package['mlocate'],
  }

}
