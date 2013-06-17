# Class: puppet-archlinux-macbookretina::firewall_pre
#
# Define firewall rules that will always be at the beginning of the chain
#
# Parameters:
#
# Actions:
#   - Set firewall rules to allow icmp, everything on lo and related/established connections
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::firewall_pre {

  Firewall {
    require => undef,
  }

  # Default firewall rules
  firewall { '000 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 accept related established rules':
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }

}
