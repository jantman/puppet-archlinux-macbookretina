# Class: puppet-archlinux-macbookretina::base
#
# Install base packages we want on any (arch) system
#
# Parameters:
#
# Actions:
#   - Install lsb-release
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::base {
  package {'lynx': ensure => present, }
  package {'lsb-release': ensure => present, }
  package {'dmidecode': ensure => present, }
  package {'macfanctld-git': ensure => present, }
  package {'alsa-utils': ensure => present, }
  package {'ttf-dejavu': ensure => present, }

  # base config files
  file {'/etc/makepkg.conf':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/puppet-archlinux-macbookretina/makepkg.conf',
  }

}
