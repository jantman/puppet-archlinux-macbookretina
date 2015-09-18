# Class: archlinux_macbookretina::macfanctld
#
# Install driver for Broadcom macfanctld, iw and wpa_supplicant
#
# Parameters:
#
# Actions:
#   - Install broadcom-wl
#   - Install iw and wpa_supplicant
#
class archlinux_macbookretina::macfanctld {

  package {'macfanctld':
    ensure => present,
  }

  service {'macfanctld':
    ensure => running,
    enable => true,
  }

}
