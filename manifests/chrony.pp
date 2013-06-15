# Class: puppet-archlinux-macbookretina::chrony
#
# Install and configure chrony, a roaming/laptop friendly NTP client
#
# Parameters:
#
# Actions:
#   - Install chrony
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::chrony {

  package {'chrony':
    ensure => present,
  }

#  file {'/etc/chrony.conf':
#    ensure  => present,
#    owner   => 'root',
#    group   => 'root',
#    mode    => '0644',
#    source  => 'puppet:///modules/puppet-archlinux-macbookretina/chrony.conf',
#    require => Package['chrony'],
#  }

  # service chrony

}
