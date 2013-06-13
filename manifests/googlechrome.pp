# Class: puppet-archlinux-macbookretina::googlechrome
#
# Install proprietary google-chrome package and ttf-google-fonts-git from archlinuxfr repository.
#
# Parameters:
#
# Actions:
#   - Install google-chrome
#   - Install ttf-google-fonts-git
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::googlechrome {

  package {'google-chrome':
    ensure  => present,
    # we get this file from yaourt class
    require => File['/etc/pacman.d/archlinuxfr.conf'],
  }

  package {'ttf-google-fonts-git':
    ensure => present,
  }

}
