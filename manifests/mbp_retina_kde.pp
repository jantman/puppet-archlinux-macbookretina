# Class: puppet-archlinux-macbookretina::mbp_retina_kde
#
# Setup KDM/KDE specific to the MacBook Pro Retina - setup kdmrc
#
# Parameters:
#
# Actions:
#   - Setup kdmrc
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::mbp_retina_kde {

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
