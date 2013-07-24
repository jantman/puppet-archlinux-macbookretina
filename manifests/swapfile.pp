# Class: puppet-archlinux-macbookretina::swapfile
#
# Creates a swap file, makes swap, swapon, update fstab
#
# Parameters:
#
# Actions:
#   - Install and configure swap file
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::swapfile {

  $swapfile_path = '/swapfile'
  $swapfile_size = '4G'

  file { $swapfile_path:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => Exec['fallocate-swap'],
  }

  exec { 'fallocate-swap':
    path    => '/usr/bin',
    command => "/usr/bin/fallocate -l ${swapfile_size} ${swapfile_path}",
    creates => $swapfile_path,
    notify  => Exec['mkswap-swapfile'],
  }

  exec { 'mkswap-swapfile':
    path        => '/usr/bin',
    command     => "/usr/bin/mkswap ${swapfile_path}",
    refreshonly => true,
    notify      => Exec['swapon-swapfile'],
  }

  exec { 'swapon-swapfile':
    path        => '/usr/bin',
    command     => "/usr/bin/swapon ${swapfile_path}",
    refreshonly => true,
  }

  augeas {'swapfile':
    context => '/files/etc/fstab',
    incl    => '/etc/fstab',
    lens    => 'fstab.lns',
    changes => [
      "set 01/spec '${swapfile_path}'",
      "set 01/file none",
      "set 01/vfstype swap",
      "set 01/opt defaults",
      "set 01/dump 0",
      "set 01/passno 0",
    ],
    onlyif  => "match *[spec='${swapfile_path}'] size == 0",
  }

}
