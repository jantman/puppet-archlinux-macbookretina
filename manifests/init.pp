# Class: archlinux_macbookretina
#
# Include all working archlinux_macbookretina::* classes
#
# Actions:
#   - Include other classes
#
# Requires:
#
# Sample Usage:
#
class archlinux_macbookretina {

  # make sure we're on Arch, otherwise fail
  if $::osfamily != 'Archlinux' {
    fail("${::operatingsystem} not supported")
  }

  case $::productname {
    'MacBookPro10,1': { $cant_have_an_empty_block = true }
    'MacBookPro11,4': { $cant_have_an_empty_block = true }
    default: {
      fail("${::productname} is not a supported hardware productname")
    }
  }

  # Install proprietary nvidia driver for nvidia graphics and sample xorg.conf
  class {'archlinux_macbookretina::videodriver':
    driver => 'nvidia', # default
  }

  # Install driver for Broadcom wireless, iw and wpa_supplicant
  include archlinux_macbookretina::wireless

  # setup the apple kernel module for the mac keyboard
  include archlinux_macbookretina::mac_keyboard

  # SSD tuning
  include archlinux_macbookretina::ssd

  # fan control
  include archlinux_macbookretina::macfanctld

  # touchpad setup
  include archlinux_macbookretina::touchpad
}
