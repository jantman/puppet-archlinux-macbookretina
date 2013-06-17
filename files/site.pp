##############################################################
# WARNING - WARNING - WARNING
# This file is managed by the puppet-archlinux-macbookretina
#  puppet module. Any local changes made here will be 
#  overwritten on the next Puppet run. Please change the
#  file in the puppet module for persistent changes.
##############################################################

# for the ssd class
# sysctl::value needs the default exec path set; lets set it to root's default
Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl' }

# for the iptables and firewall stuff
resources { "firewall":
  purge => true,
}

# this ensures that the _pre and _post classes are run in that order, to make sure we don't get locked out of the box
Firewall {
  before  => Class['puppet-archlinux-macbookretina::firewall_post'],
  require => Class['puppet-archlinux-macbookretina::firewall_pre'],
}

# this sets up default allow rules so we don't gronk the box
class {'puppet-archlinux-macbookretina::firewall_pre':
  require => File['/etc/conf.d/iptables'],
}

# this sets up a default drop rule and makes sure it's last
class {'puppet-archlinux-macbookretina::firewall_post' : }

# this installs the require packages (iptables)
class {'firewall': }

node default {
  include puppet-archlinux-macbookretina
}
