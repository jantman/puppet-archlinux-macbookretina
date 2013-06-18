# Class: puppet-archlinux-macbookretina::arch_base
#
# Install base packages we want on any (arch) system and setup makepkg.conf
#
# Parameters:
#
# Actions:
#   - Install lsb-release, dmidecode
#   - Install macfanctld-git
#   - Install alsa-utils, ttf-dejavu
#   - Install links, make sure lynx isnt on the system
#   - Install screen
#   - Setup /etc/makepkg.conf for system-optimized compiling
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::arch_base {
  package {'links': ensure => present, }
  package {'lynx': ensure => absent, }
  package {'lsb-release': ensure => present, }
  package {'dmidecode': ensure => present, }
  package {'macfanctld-git': ensure => present, }
  package {'alsa-utils': ensure => present, }
  package {'ttf-dejavu': ensure => present, }
  package {'screen': ensure => present, }
  package {'hdparm': ensure => present, }
  package {'wget': ensure => present, }

  # base config files
  file {'/etc/makepkg.conf':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/puppet-archlinux-macbookretina/makepkg.conf',
  }

  # these are needed for compiling packages under /tmp using makepkg
  file {'/tmp/sources':
    ensure => directory,
    owner  => 'root',
    group  => 'wheel',
    mode   => '775',
  }

  # need this for a bunch of puppet stuff
  file {'/etc/puppet/manifests/site.pp':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/puppet-archlinux-macbookretina/site.pp',
  }

}
