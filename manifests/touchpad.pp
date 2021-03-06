#
# Set up the MBP touchpad using synaptics driver and configure it.
#
# - install ``xf86-input-synaptics``
# - ensure ``xf86-input-mtrack-git`` is absent
# - setup ``/etc/X11/xorg.conf.d/00-touchpad.conf`` from template
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
