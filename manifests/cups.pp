# Class: archlinux_macbookretina::cups
#
# Install CUPS printing
#
# Parameters:
#
# Actions:
#   - Install cups
#
# Requires:
#
# Sample Usage:
#
class archlinux_macbookretina::cups {

  $cups_packages = ['libcups', 'cups', 'ghostscript', 'gsfonts', 'gutenprint', 'foomatic-db', 'foomatic-filters', 'hplip', 'cups-pdf']

  package {$cups_packages:
    ensure => present,
  }

  service {'cups':
    ensure  => running,
    enable  => true,
    require => Package['cups'],
  }

}

