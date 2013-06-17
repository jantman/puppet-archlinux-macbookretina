# Class: puppet-archlinux-macbookretina::profilesyncdaemon
#
# Install and configure profile-sync-daemon - REQUIRES CONFIGURATION
#
# See: https://wiki.archlinux.org/index.php/Profile-sync-daemon
#
# Parameters:
#
# Actions:
#   - Install profile-sync-daemon
#   - Configure it for specified users
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::profilesyncdaemon {

  $profile_sync_users = 'jantman'

  file { '/etc/psd.conf':
    ensure   => present,
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    content  => template('puppet-archlinux-macbookretina/psd.conf.erb'),
    require  => Package['profile-sync-daemon'],
  }

  # this is an AUR package
  package {'profile-sync-daemon':
    ensure => present,
  }

#  service {'psd':
#    ensure => running,
#    enable => true,
#  }

#  service {'psd-resync':
#    ensure => running,
#    enable => true,
#  }

}
