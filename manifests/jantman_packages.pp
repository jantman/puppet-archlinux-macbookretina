# Class: puppet-archlinux-macbookretina::jantman_packages
#
# Packages largely specific to jantman's workstation setup
#
# Parameters:
#
# Actions:
#   - Install davmail
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::jantman_packages {

  # this is an AUR package
  package {'davmail': ensure => present, }

}
