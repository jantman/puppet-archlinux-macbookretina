# Class: archlinux_macbookretina::wireless
#
# Install driver for Broadcom wireless, iw and wpa_supplicant
#
# Parameters:
#
# Actions:
#   - Install broadcom-wl
#   - Install iw and wpa_supplicant
#
class archlinux_macbookretina::wireless {

  case $::productname {
    'MacBookPro10,1': {
      # we could also use the open source [b43-firmware](https://aur.archlinux.org/packages/b43-firmware/)
      # for a custom kernel, we'll need https://aur.archlinux.org/packages/broadcom-wl-dkms/
      package {'broadcom-wl':
        ensure => present,
      }
    }
    default: {
      notify {"using built-in kernel drivers for wireless on ${::productname}": }
    }
  }

  package {'iw':
    ensure => present,
  }

  package {'wpa_supplicant':
    ensure => present,
  }

}
