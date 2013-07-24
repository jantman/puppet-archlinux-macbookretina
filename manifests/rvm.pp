# Class: puppet-archlinux-macbookretina::rvm
#
# Install prerequisites for ruby rvm

#
# Parameters:
#
# Actions:
#   - update /etc/gemrc
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::rvm {

  file { '/etc/gemrc':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/gemrc',
  }

}
