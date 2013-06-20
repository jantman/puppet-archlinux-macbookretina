# Class: puppet-archlinux-macbookretina::refind
#
# Make /etc/mkinitcpio.d/linux.preset changes for booting via rEFInd
#
# Parameters:
#
# Actions:
#   - Install modified version of /etc/mkinitcpio.d/linux.preset
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::refind {

  file {'/etc/mkinitcpio.d/linux.preset':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/mkinitcpio_rEFInd_linux.preset',
  }

}
