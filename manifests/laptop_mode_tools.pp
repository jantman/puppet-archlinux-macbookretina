# Class: puppet-archlinux-macbookretina::laptop_mode_tools
#
# Install and configute laptop-mode-tools for power saving
#
# Parameters:
#
# Actions:
#   - Install laptop-mode-tools
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::laptop_mode_tools {

  package {'laptop-mode-tools':
    ensure => present,
  }

}
