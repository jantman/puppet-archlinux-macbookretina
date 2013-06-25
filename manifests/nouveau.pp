# Class: puppet-archlinux-macbookretina::nouveau
#
# Install nouveau driver for nvidia graphics and sample xorg.conf. Choose this class OR nvidia.
#
# Parameters:
#
# Actions:
#   - Install xf86-video-nouveau
#   - Install /etc/X11/xorg.conf with MBP Retina customization
#
# Requires:
#
# Sample Usage:
#
#   Uncomment EITHER the "nouveau" or "nvidia" line in makeinitpp.sh. 
#   Run makeinitpp.sh
#
class puppet-archlinux-macbookretina::nouveau {

  $nouveau_packages = ['xf86-video-nouveau',  'nouveau-dri', 'mesa-libgl', 'lib32-mesa-libgl' ]
  $nvidia_packages = [ 'nvidia' ]

  package {$nouveau_packages:
    ensure  => present,
    notify  => Exec['mkinitcpio'],
    require => Package[$nvidia_packages],
  }

  package {$nvidia_packages:
    ensure => absent,
  }

  file { '/etc/X11/xorg.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/xorg.conf.nouveau',
    require => Package['xorg-server'],
  }

}
