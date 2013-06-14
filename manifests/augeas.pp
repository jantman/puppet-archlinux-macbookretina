# Class: puppet-archlinux-macbookretina::augeas
#
# Install augeas, required for some of the puppet classes
#
# Parameters:
#
# Actions:
#   - Install augeas
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::augeas {

  package {'augeas':
    ensure => present,
  }

  package {'ruby-augeas':
    ensure => present,
  }

}
