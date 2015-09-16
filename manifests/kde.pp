# Class: archlinux_macbookretina::kde
#
# Install KDM and KDE basics and run kdm
#
# Parameters:
#
# Actions:
#   - Install kdm and kde
#   - Run kdm service
#
# Requires:
#
# Sample Usage:
#
class archlinux_macbookretina::kde {

  service {'kdm.service':
    enable  => true,
    ensure  => running,
    require => Package['kdebase-workspace'],
  }

  $kde_packages = ['kdebase', 'kdebase-workspace', 'kdeutils-kwallet', 'kdenetwork-krdc', 'rdesktop', 'kdemultimedia-kmix', 'kdegraphics-ksnapshot', 'freerdp' ]

  package {$kde_packages:
    ensure => present,
  }

}
