# Class: archlinux_macbookretina::macfanctld
#
# Install macfanctld
#
# Parameters:
#
# Actions:
#   - Install macfanctld
#
class archlinux_macbookretina::macfanctld {

  # AUR package
  package {'macfanctld':
    ensure => present,
  }

  service {'macfanctld':
    ensure => running,
    enable => true,
  }

}
