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

  package {'nvidia':
    ensure => present,
  }

#  file { '/etc/X11/xorg.conf':
#    ensure  => present,
#    owner   => 'root',
#    group   => 'root',
#    mode    => '0644',
#    source  => 'puppet:///modules/puppet-archlinux-macbookretina/xorg.conf',
#    require => Package['xorg-server'],
#  }

}
