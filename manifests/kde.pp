# Class: puppet-archlinux-macbookretina::kde
#
# Install KDM and KDE baics
#
# Parameters:
#
# Actions:
#   - Install kdm and kde
#   - Setup kdmrc
#   - Run kdm service
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::kde {

  service {'kdm.service':
    enable  => true,
    ensure  => running,
    require => Package['kdebase-workspace'],
  }

  $kde_packages = ['kdebase', 'kdebase-workspace']

  package {$kde_packages:
    ensure => present,
  }

  file {'kdmrc':
    ensure  => present,
    path    => '/usr/share/config/kdm/kdmrc',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/kdmrc',
    require => Package['kdebase-workspace'],
  }

}
