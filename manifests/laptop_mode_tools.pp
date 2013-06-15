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

  file {'/etc/laptop-mode/laptop-mode.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/laptop-mode.conf',
    require => Package['laptop-mode-tools'],
  }

  # service laptop-mode

}
