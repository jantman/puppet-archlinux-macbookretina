# Class: puppet-archlinux-macbookretina::mozilla_profilemanager
#
# Install Mozilla ProfileManager for Firefox as an ugly binary untar
#
# Parameters:
#
# Actions:
#   - wget and untar mozilla profile manager
#   - setup a profilemanager .desktop link file
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::mozilla_profilemanager {

  # we don't want this in /tmp since it's a ramdisk and would get re-done at every reboot
  $tmp_dir = "/root/mozilla-profilemanager"

  # To Do: make this a real package and get it on AUR. Get rid of this ugliness
  file { $tmp_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  } ->
  exec { "wget-profilemanager":
    command => "/bin/wget -O ${tmp_dir}/profilemanager.linux64.tar.gz ftp://ftp.mozilla.org/pub/mozilla.org/utilities/profilemanager/1.0/profilemanager.linux64.tar.gz",
    creates => "${tmp_dir}/profilemanager.linux64.tar.gz",
    cwd     => $tmp_dir,
    require => Package['wget'],
  } ->
  exec { "untar-profilemanager":
    command => "/bin/tar -xzvf ${tmp_dir}/profilemanager.linux64.tar.gz",
    creates => "/usr/local/bin/profilemanager/profilemanager-bin",
    cwd     => "/usr/local/bin",
  } -> 
  file { "/usr/share/applications/mozilla-profilemanager.desktop":
    ensure => present,
    source => 'puppet:///modules/puppet-archlinux-macbookretina/mozilla-profilemanager.desktop',
  }

}
