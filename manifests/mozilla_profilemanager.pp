# Class: puppet-archlinux-macbookretina::mozilla_profilemanager
#
# Install Mozilla ProfileManager for Firefox
#  https://developer.mozilla.org/en-US/docs/Profile_Manager
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

  # To Do: make this a real package and get it on AUR. Get rid of this ugliness
#  file { "/tmp/mozilla-profilemanager":
#    ensure => directory,
#    owner  => 'root',
#    group  => 'root',
#  } ->
#  exec { "wget-profilemanager":
#    command => "/bin/wget -O /tmp/mozilla-profilemanager/profilemanager.linux64.tar.gz ftp://ftp.mozilla.org/pub/mozilla.org/utilities/profilemanager/1.0/profilemanager.linux64.tar.gz",
#    creates => "/root/temp/mozilla-profilemanager/profilemanager.linux64.tar.gz",
#    cwd     => "/root/temp/mozilla-profilemanager/",
#  } ->
#  exec { "untar-profilemanager":
#    command => "/bin/tar -xzvf /tmp/mozilla-profilemanager/profilemanager.linux64.tar.gz",
#    creates => "/usr/local/bin/profilemanager/profilemanager-bin",
#    cwd     => "/usr/local/bin",
#  } -> 
#  file { "/usr/share/applications/mozilla-profilemanager.desktop":
#    ensure => present,
#    source => 'puppet:///modules/puppet-archlinux-macbookretina/mozilla-profilemanager.desktop',
#  }

}
