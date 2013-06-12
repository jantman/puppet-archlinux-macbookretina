# Class: puppet-archlinux-macbookretina::networkmanager
#
# Install and setup networkmanager its KDE components, and do initial configuration
#
# Parameters:
#
# Actions:
#   - Install networkmanager and its related components
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::networkmanager {

  package {'networkmanager':
    ensure => present,
  } ->
  package {'kdeplasma-applets-networkmanagement':
    ensure  => present,
    require => Package['networkmanager'],
  } ->
  service {'NetworkManager':
    ensure  => running,
    enable  => true,
    require => Package['networkmanager'],
  } ->
  service {'dhcpcd':
    ensure  => stopped,
    enable  => false,
    require => Service['NetworkManager'],
  }

}
