# Class: puppet-archlinux-macbookretina::pdnsd
#
# Install and configute pdnsd for persistent local dns caching.
#
# Parameters:
#
# Actions:
#   - Install pdnsd
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::pdnsd {

  package {'pdnsd':
    ensure => present,
  }

  file {'/etc/pdnsd.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/pdnsd.conf',
    require => Package['pdnsd'],
  }

  # service pdnsd

}
