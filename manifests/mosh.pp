# Class: archlinux_macbookretina::mosh
#
# Install mosh (mobile shell) and set firewall rules for it
#
# See: http://mosh.mit.edu/
#
# Parameters:
#
# Actions:
#   - Install mosh
#   - Firewall rules to allow UDP ports 60000:61000
#
# Requires:
#
# Sample Usage:
#
class archlinux_macbookretina::mosh {

  package {'mosh':
    ensure => present,
  }

  firewall { '101 allow mosh':
    port   => '60000-61000',
    proto  => udp,
    action => accept,
  }

}

