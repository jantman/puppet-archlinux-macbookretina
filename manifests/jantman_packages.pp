# Class: puppet-archlinux-macbookretina::jantman_packages
#
# Packages largely specific to jantman's workstation setup
#
# Parameters:
#
# Actions:
#   - Install davmail
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::jantman_packages {

  # this is an AUR package
  package {'davmail': ensure => present, }

  # emacs
  package {'emacs-nox': ensure => present, }
  package {'emacs-pkgbuild-mode': ensure => present, }

  # internet service clients
  package {'irssi': ensure => present, }
  package {'perl-net-dbus': ensure => present, } # for irssi libnotify plugin, from AUR package irssi-libnotify-git or local perl script
  package {'purple-plugin-pack': ensure => present, }
  package {'pidgin': ensure => present, }
  package {'pidgin-libnotify': ensure => present, }
  package {'pidgin-otr': ensure => present, }
  package {'skype': ensure => present, }
  package {'teamspeak3': ensure => present, }
  package {'teamviewer': ensure => present, }

  # misc dev/editing
  package {'meld': ensure => present, }
  package {'kdesdk-kate': ensure => present, }
  package {'eclipse': ensure => present, }
  package {'rpmextract': ensure => present, }
  package {'cpio': ensure => present, }

  # graphical environment misc
  package {'kdegraphics-okular': ensure => present, }

  # mozilla
  package {'firefox': ensure => present, }
  package {'arch-firefox-search': ensure => present, }
  package {'thunderbird': ensure => present, }
  package {'lightning-bin': ensure => present, }

  # keychain/askpass
  package {'keychain': ensure => present, }
  package {'ksshaskpass': ensure => present, }

  # FUSE/sshfs
  package {'fuse': ensure => present, }
  package {'sshfs': ensure => present, }

  # review board client tools
  package {'rbtools': ensure => present, }

  # java
  package {'icedtea-web-java7': ensure => present, }

  # misc
  package {'diffutils': ensure => present, }
  package {'kdeartwork-kscreensaver': ensure => present, }
  package {'kdegraphics-gwenview': ensure => present, }
  package {'kdetoys-kteatime': ensure => present, }
  package {'keepassx': ensure => present, }
  package {'libvirt': ensure => present, }
  package {'minicom': ensure => present, }
  package {'multitail': ensure => present, }
  package {'gnu-netcat': ensure => present, }
  package {'net-snmp': ensure => present, }
  package {'perl-net-snmp': ensure => present, }
  package {'nmap': ensure => present, }
  package {'pdftk': ensure => present, }
  package {'strace': ensure => present, }
  package {'tcpdump': ensure => present, }
  package {'traceroute': ensure => present, }
  package {'vlc': ensure => present, }
  package {'wireshark-cli': ensure => present, }
  package {'wireshark-gtk': ensure => present, }
  package {'xscreensaver': ensure => present, }
  #package {'mysql-workbench': ensure => present, }
  package {'kdeutils-kcalc': ensure => present, }
  package {'syslinux': ensure => present, }
  package {'mtools': ensure => present, }
  package {'dosfstools': ensure => present, }
  package {'ntfsprogs': ensure => present, }

  # FEDORA PACKAGES - need to check arch package names
  #package {'cdpr': ensure => present, }
  #package {'fslint': ensure => present, }
  #package {'python': ensure => present, }
  #package {'python-VirtualBox': ensure => present, }
  #package {'python-virtualenv': ensure => present, }

}
