# Class: archlinux_macbookretina::touchpad
#
# Set up the MBP touchpad using synaptics driver
#
# Parameters:
#
# Actions:
#   - install xf86-input-synaptics
#   - ensure xf86-input-mtrack-git is absent
#   - setup /etc/X11/xorg.conf.d/00-touchpad.conf
#
# Requires:
#
# Sample Usage:
#
class archlinux_macbookretina::touchpad {

  package {'xf86-input-mtrack-git':
    ensure => absent,
  }

  package {'xf86-input-synaptics':
    ensure => present,
  }
  -> file { '/etc/X11/xorg.conf.d/00-touchpad.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('archlinux_macbookretina/00-touchpad.conf.erb'),
  }

}
