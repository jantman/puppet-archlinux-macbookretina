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
class puppet-archlinux-macbookretina::nouveau {

  package {'xf86-video-nouveau':
    ensure => present,
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
