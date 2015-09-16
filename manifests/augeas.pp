# Class: archlinux_macbookretina::augeas
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
class archlinux_macbookretina::augeas {

  package {'augeas':
    ensure => present,
  }

  package {'ruby-augeas':
    ensure => present,
  }

}
