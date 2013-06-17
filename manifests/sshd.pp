# Class: puppet-archlinux-macbookretina::sshd
#
# Install and setup OpenSSH, drop in sshd_config

#
# Parameters:
#
# Actions:
#   - Install openssh
#   - Seed /etc/ssh/sshd_config which allows key auth only, and no root login
#   - Setup firewall rule to allow ssh on port 22 from anywhere
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

  # this requires our iptables class and all of its dependencies
  firewall { '100 allow ssh':
    port   => 22,
    proto  => tcp,
    action => accept,
  }

}
