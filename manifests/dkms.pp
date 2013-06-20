# Class: puppet-archlinux-macbookretina::dkms
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
class puppet-archlinux-macbookretina::dkms {

  package {'dkms':
    ensure => present,
  }

  service {'dkms':
    ensure => running,
    enable => true,
  }

}
