# Class: puppet-archlinux-macbookretina::nouveau
#
# Install nouveau driver for nvidia graphics
#
# Parameters:
#
# Actions:
#   - Install xf86-video-nouveau
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::nouveau {

  package {'xf86-video-nouveau':
    ensure => present,
  }

}
