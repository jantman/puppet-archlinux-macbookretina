# Class: puppet-archlinux-macbookretina::virtualbox
#
# Install and configure VirtualBox and Vagrant
#
# Parameters:
#
# Actions:
#   - Install virtualbox package
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::virtualbox {

  package {'virtualbox':
    ensure => present,
  }

  package {'virtualbox-host-modules':
    ensure => present,
  }

  package {'vagrant':
    ensure => present,
  }

  # note - left off at "Setup" https://wiki.archlinux.org/index.php/VirtualBox#Setup
  # also need to do extension pack: https://wiki.archlinux.org/index.php/VirtualBox_Extras#Extension_pack

}
