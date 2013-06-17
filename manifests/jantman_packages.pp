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
  package {'purple-plugin-pack': ensure => present, }
  package {'pidgin': ensure => present, }
  package {'pidgin-libnotify': ensure => present, }
  package {'pidgin-otr': ensure => present, }
  package {'skype2': ensure => present, }

  # misc dev/editing
  package {'meld': ensure => present, }
  package {'kdesdk-kate': ensure => present, }
  package {'eclipse': ensure => present, }

  # graphical environment misc
  package {'kdegraphics-okular': ensure => present, }

  # mozilla
  package {'firefox': ensure => present, }
  package {'arch-firefox-search': ensure => present, }
  package {'thunderbird': ensure => present, }
  package {'lightning-bin': ensure => present, }

  # FEDORA PACKAGES - need to check arch package names
  #package {'cdpr': ensure => present, }
  #package {'dia': ensure => present, }
  #package {'diffutils': ensure => present, }
  #package {'fslint': ensure => present, }
  #package {'fuse': ensure => present, }
  #package {'fuse-libs': ensure => present, }
  #package {'fuse-sshfs': ensure => present, }
  #package {'gwenview': ensure => present, }
  #package {'kdeartwork-screensavers': ensure => present, }
  #package {'kdetoys': ensure => present, }
  #package {'keepassx': ensure => present, }
  #package {'keychain': ensure => present, }
  #package {'keyutils': ensure => present, }
  #package {'ksshaskpass': ensure => present, }
  #package {'libvirt-client': ensure => present, }
  #package {'libvirt': ensure => present, }
  #package {'minicom': ensure => present, }
  #package {'Mosaic': ensure => present, }
  #package {'multitail': ensure => present, }
  #package {'nc': ensure => present, }
  #package {'net-snmp': ensure => present, }
  #package {'net-snmp-libs': ensure => present, }
  #package {'net-snmp-utils': ensure => present, }
  #package {'nmap': ensure => present, }
  #package {'pdftk': ensure => present, }
  #package {'python': ensure => present, }
  #package {'python-VirtualBox': ensure => present, }
  #package {'python-virtualenv': ensure => present, }
  #package {'rsync': ensure => present, }
  #package {'spice-client': ensure => present, }
  #package {'spice-server': ensure => present, }
  #package {'spice-xpi': ensure => present, }
  #package {'sqlite': ensure => present, }
  #package {'strace': ensure => present, }
  #package {'tcpdump': ensure => present, }
  #package {'telnet': ensure => present, }
  #package {'thunderbird': ensure => present, }
  #package {'traceroute': ensure => present, }
  #package {'vlc-core': ensure => present, }
  #package {'vlc-devel': ensure => present, }
  #package {'vlc': ensure => present, }
  #package {'vlc-extras': ensure => present, }
  #package {'wireshark': ensure => present, }
  #package {'wireshark-gnome': ensure => present, }
  #package {'xscreensaver-extras-base': ensure => present, }
  #package {'xscreensaver-extras': ensure => present, }
  #package {'xscreensaver-gl-base': ensure => present, }
  #package {'xscreensaver-gl-extras': ensure => present, }
  #package {'mysql-workbench': ensure => present, }
}
