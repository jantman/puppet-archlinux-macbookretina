# Class: puppet-archlinux-macbookretina::xorg
#
# Install packages required for xorg X server
#
# Parameters:
#
# Actions:
#   - Install X server required packages
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::xorg {

  $xorg_packages = ['xorg-server', 'xorg-apps', 'xorg-server-utils', 'xorg-xinit', 'mesa']

  package {$xorg_packages:
    ensure => present,
  }

}
