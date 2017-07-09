# Class: archlinux_macbookretina::webcam
#
# Install reverse-engineered driver for FacetimeHD (Broadcom 1570) PCIe webcam,
# using AUR packages. Driver source: https://github.com/patjak/bcwc_pcie/.
# MacBookPro11,4 only.
#
# Parameters:
#
# Actions:
#   - Install bcwc-pcie-git and facetimehd-firmware on MacBookPro11,4
#
class archlinux_macbookretina::webcam {

  case $::productname {
    'MacBookPro11,4': {
      package {'bcwc-pcie-git':
        ensure => present,
      }

      package {'facetimehd-firmware':
        ensure => present,
      }
    }
    default: {
      notify {"archlinux_macbookretina does not know how to configure webcam on: ${::productname}": }
    }
  }

}
