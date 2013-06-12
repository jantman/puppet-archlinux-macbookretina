# Class: puppet-archlinux-macbookretina::wireless
#
# Install driver for Broadcom BCM4331 wireless
#
# Note that we're using the bcm43142 package from AUR, but that appears to have
# the 6.20.x driver which supports BCM4331.
#
# Parameters:
#
# Actions:
#   - Install wireless-broadcom-bcm43142
#   - Install iw and wpa_supplicant
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::wireless {

  # @TODO: look for a specific bcm4331 package, or wait for this to get renamed more generically
  package {'wireless-bcm43142-dkms':
    ensure => present,
  }

  package {'iw':
    ensure => present,
  }

  package {'wpa_supplicant':
    ensure => present,
  }

}
