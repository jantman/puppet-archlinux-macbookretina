# Class: puppet-archlinux-macbookretina::sshd
#
# Install and setup OpenSSH
#
# Parameters:
#
# Actions:
#   - Install openssh
#   - Seed /etc/ssh/sshd_config which allows key auth only, and no root login
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::sshd {

  file { '/etc/ssh/sshd_config':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/sshd_config',
    require => Package['openssh'],
  }

  package {'openssh':
    ensure => present,
  }

}
