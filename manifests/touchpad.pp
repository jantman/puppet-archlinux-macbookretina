# Class: archlinux_macbookretina::touchpad
#
# Set up the MBP touchpad using mtrack
#
# Parameters:
#
# Actions:
#   - install xf86-input-mtrack-git (AUR package)
#
# Requires:
#
# Sample Usage:
#
class archlinux_macbookretina::touchpad {

  # https://aur.archlinux.org/packages/xf86-input-mtrack-git/
  package {'xf86-input-mtrack-git':
    ensure => present,
  }

  file { "/etc/X11/xorg.conf.d/00-touchpad.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('archlinux_macbookretina/00-touchpad.conf.erb'),
  }

}
