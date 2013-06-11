# Class: puppet-archlinux-macbookretina::xorg
#
# Install default xorg.conf, and packages required for X server
#
# Parameters:
#
# Actions:
#   - Install /etc/X11/xorg.conf
#   - Install X server required packages
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::xorg {

  file { '/etc/X11/xorg.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/xorg.conf',
    require => Package['xorg-server'],
  }

  $xorg_packages = ['xorg-server', 'xorg-apps', 'xorg-server-utils', 'xorg-xinit', 'mesa']

  package {$xorg_packages:
    ensure => present,
  }

}
