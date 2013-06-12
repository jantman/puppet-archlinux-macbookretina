# Class: puppet-archlinux-macbookretina::mbp_retina_xorg
#
# Install default xorg.conf for MacBook Pro Retina
#
# Parameters:
#
# Actions:
#   - Install /etc/X11/xorg.conf
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::mbp_retina_xorg {

  file { '/etc/X11/xorg.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/xorg.conf',
    require => Package['xorg-server'],
  }

}
