# Class: puppet-archlinux-macbookretina::yaourt
#
# Configure pacman.conf to include files from pacman.d/*.conf
# Then setup the Yaourt https://wiki.archlinux.org/index.php/Yaourt
#  tool for Puppet to install packages via AUR
#
# Parameters:
#
# Actions:
#   - Setup /etc/pacman.conf to include /etc/pacman.d/*.conf
#   - Add archlinuxfr repository so we can install yaourt via pacman
#   - run pacman --sync --refresh yaourt when the repo file changes
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::yaourt {

  file { '/etc/pacman.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/pacman.conf',
  }

  file {'/etc/pacman.d/archlinuxfr.conf':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/puppet-archlinux-macbookretina/archlinuxfr.conf',
    notify => Exec['pacman_sync_yaourt'],
  }

  exec {'pacman_sync_yaourt':
    refreshonly => 'true',
    user        => 'root',
    command     => 'pacman --sync --refresh yaourt',
  }

}
