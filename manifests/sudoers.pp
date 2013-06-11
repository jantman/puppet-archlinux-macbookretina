# Class: puppet-archlinux-macbookretina::sudoers
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
class puppet-archlinux-macbookretina::sudoers {

  file { '/etc/sudoers':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
    source => 'puppet:///modules/puppet-archlinux-macbookretina/sudoers',
  }

}
