# Class: puppet-archlinux-macbookretina::openvpn
#
# Install and setup networkmanager OpenVPN and its NetworkManager part
#
# Note that we're using the bcm43142 package from AUR, but that appears to have
# the 6.20.x driver which supports BCM4331.
#
# Parameters:
#
# Actions:
#   - Install openvpn and networkmanager-openvpn
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::openvpn {

  package {'networkmanager-openvpn':
    ensure => present,
  }

  package {'openvpn':
    ensure => present,
  }

}
