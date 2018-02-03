#
# Install macfanctld package and enable the macfanctld service.
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
