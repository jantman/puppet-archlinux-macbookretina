# Class: puppet-archlinux-macbookretina::yaourt
#
# Add the archlinuxfr repo to pacman, install yaourt <https://wiki.archlinux.org/index.php/Yaourt> so we can get packages from AUR
#
# Parameters:
#
# Actions:
#   - Setup /etc/pacman.conf to include /etc/pacman.d/archlinuxfr.conf
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
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/archlinuxfr.conf',
    notify  => Exec['pacman_sync_yaourt'],
    require => File['/etc/pacman.conf'],
  }

  exec {'pacman_sync_yaourt':
    refreshonly => 'true',
    user        => 'root',
    command     => '/usr/bin/pacman --noconfirm --sync --refresh yaourt',
    require     => File['/etc/pacman.d/archlinuxfr.conf'],
  }

}
