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
#   - Setup /etc/makepkg.conf for system-optimized compiling and compiling in tmpfs
#   - Setup systemd service to run script to create tmpfs compile dir on boot
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
  package {'tmux': ensure => present, }
  package {'hdparm': ensure => present, }
  package {'wget': ensure => present, }
  package {'dnsutils': ensure => present, }
  package {'net-tools': ensure => present, }
  package {'lsof': ensure => present, }

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

  # the following ensures that /tmp/sources is created at boot, even if puppet isnt run
  file {'/usr/local/bin/maketmpdirs.sh':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/puppet-archlinux-macbookretina/maketmpdirs.sh',
  }
  file {'/etc/systemd/system/maketmpdirs.service':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/maketmpdirs.service',
    require => File['/usr/local/bin/maketmpdirs.sh'],
  }
  service {'maketmpdirs':
    ensure  => running,
    enable  => true,
    require => File['/etc/systemd/system/maketmpdirs.service'],
  }

}
