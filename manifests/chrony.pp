# Class: puppet-archlinux-macbookretina::chrony
#
# Install and configure chrony, a roaming/laptop friendly NTP client
#
# Parameters:
#
# Actions:
#   - Install chrony
#   - Install networkmanager-dispatcher-chrony for nm to tell chrony when we're on/offline
#   - Setup /etc/chrony.conf
#   - Setup /etc/chrony.keys with a static password
#   - Run the chrony service
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::chrony {

  # we're only allowing access from 127.0.0.1, so I don't see a reason
  # to be paranoid about this. Change it if you want.
  $chrony_password = 'd83ja72.f83,8wHUW94'

  package {'chrony':
    ensure => present,
  }

  # nm hooks to tell chrony when we're on/offline
  package {'networkmanager-dispatcher-chrony':
    ensure => present,
  }

  file {'/etc/chrony.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/chrony.conf',
    require => Package['chrony'],
    notify  => Service['chrony'],
  }

  file {'/etc/chrony.keys':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => "1 ${chrony_password}",
    require => Package['chrony'],
    notify  => Service['chrony'],
  }

  service {'chrony':
    ensure => running,
    enable => true,
  }

}
