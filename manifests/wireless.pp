#
# Install wireless drivers, ``iw`` and ``wpa_supplicant``.
#
# - On MacBookPro10,1 install the ``broadcom-wl`` driver.
# - On other models, use the build-in kernel drivers.
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
