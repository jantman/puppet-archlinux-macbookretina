# Class: archlinux_macbookretina::sudoers
#
# Install sudoers file - Arch default plus allow wheel access to all (with password).
#
# Parameters:
#
# Actions:
#   - Install sudoers file
#
# Requires:
#
# Sample Usage:
#
class archlinux_macbookretina::sudoers {

  file { '/etc/sudoers':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
    source => 'puppet:///modules/archlinux_macbookretina/sudoers',
  }

}
