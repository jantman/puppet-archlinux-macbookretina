# Class: archlinux_macbookretina::rvm
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
class archlinux_macbookretina::rvm {

  file { '/etc/gemrc':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/archlinux_macbookretina/gemrc',
  }

}
