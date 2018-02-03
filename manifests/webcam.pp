#
# On MacBookPro11,4 install reverse-engineered driver for FacetimeHD (Broadcom
# 1570) PCIe webcam, using AUR packages (``bcwc-pcie-git`` and
# ``facetimehd-firmware``). Driver source:
# https://github.com/patjak/bcwc_pcie/. On other models, do nothing.
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
