# Class: archlinux_macbookretina::pommed
#
# Install and configure pommed and run service
#
# Parameters:
#
# Actions:
#   - Install pommed-light
#   - Run pommed service
#
class archlinux_macbookretina::pommed {

  # AUR package
  package {'pommed-light':
    ensure => present,
  }

  service {'pommed':
    ensure => running,
    enable => true,
  }

}
