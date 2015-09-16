# Class: archlinux_macbookretina::dkms
#
# Install, run and configure DKMS
#
# Parameters:
#
# Actions:
#   - Install dkms
#   - Enable and run the dkms service
#
# Requires:
#
# Sample Usage:
#
class archlinux_macbookretina::dkms {

  package {'dkms':
    ensure => present,
  }

  service {'dkms':
    ensure => running,
    enable => true,
  }

}
