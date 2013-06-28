# Class: puppet-archlinux-macbookretina::nvidia
#
# Install proprietary nvidia driver for nvidia graphics and sample xorg.conf. Choose this class OR nouveau.
#
# Parameters:
#
# Actions:
#   - Install nvidia
#   - Install /etc/X11/xorg.conf with MBP Retina customization
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::nvidia {

  $nouveau_packages = ['xf86-video-nouveau',  'nouveau-dri', 'mesa-libgl', 'lib32-mesa-libgl' ]
  $nvidia_packages = [ 'nvidia', 'nvidia-bl' ]

  package {$nouveau_packages:
    install_options => '-dds',
    ensure          => absent,
  }

  package {$nvidia_packages:
    ensure  => present,
    notify  => Exec['mkinitcpio'],
    require => Package[$nouveau_packages],
  }

  file { '/etc/X11/xorg.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/xorg.conf.nvidia',
    require => Package['xorg-server'],
  }

}
