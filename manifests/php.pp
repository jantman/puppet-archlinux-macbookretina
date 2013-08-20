# Class: puppet-archlinux-macbookretina::php
#
# Install PHP for CLI
#
# Parameters:
#
# Actions:
#   - Install php packages
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::php {

  $php_packages = ['php', ]

  package {$php_packages:
    ensure => present,
  }

}
