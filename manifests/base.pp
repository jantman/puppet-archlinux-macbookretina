# Class: puppet-archlinux-macbookretina::base
#
# Install base packages we want on any (arch) system
#
# Parameters:
#
# Actions:
#   - Install lsb-release
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::base {
  package {'lynx': ensure => present, }
  package {'lsb-release': ensure => present, }
}
