# Class: puppet-archlinux-macbookretina::mac_keyboard
#
# Sets up macbook-specific keyboard stuff
#
# Parameters:
#
# Actions:
#   - set modprobe.d/apple.conf with "options hid_apple fnmode=2"
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::mac_keyboard {

  file { "/etc/modprobe.d/apple.conf":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/puppet-archlinux-macbookretina/apple.conf',
  }

}
