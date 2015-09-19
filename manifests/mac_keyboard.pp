# Class: archlinux_macbookretina::mac_keyboard
#
# Sets up macbook-specific keyboard stuff
#
# Parameters:
#
# Actions:
#   - set modprobe.d/apple.conf with "options hid_apple fnmode=2"
#   - set /etc/systemd/system/kdm.service.d/kbd_backlight.conf to start upower before SDDM
#
# Requires:
#
# Sample Usage:
#
class archlinux_macbookretina::mac_keyboard {

  file { '/etc/modprobe.d/apple.conf':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/archlinux_macbookretina/apple.conf',
  }

  file { '/etc/systemd/system/kdm.service.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  } ->
  file { '/etc/systemd/system/kdm.service.d/kbd_backlight.conf':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/archlinux_macbookretina/kbd_backlight.conf',
  }

}
