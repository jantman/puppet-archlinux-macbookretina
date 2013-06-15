# Class: puppet-archlinux-macbookretina
#
# Manage includes of other puppet-archlinux-macbookretina classes
# top-level class for puppet-archlinux-macbookretina ecosystem
#
# WARNING - WARNING - this file is generated by makeinitpp.sh. 
#   any local changes will be overwritten.
#
# Parameters:
#
# Actions:
#   - Include other classes
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina {
  # Install base packages we want on any (arch) system and setup makepkg.conf
  include puppet-archlinux-macbookretina::arch_base

  # Install augeas, required for some of the puppet classes
  include puppet-archlinux-macbookretina::augeas

  # Install and configure chrony, a roaming/laptop friendly NTP client
  include puppet-archlinux-macbookretina::chrony

  # Install proprietary google-chrome package and ttf-google-fonts-git from archlinuxfr repository.
  include puppet-archlinux-macbookretina::googlechrome

  # Install KDM and KDE basics and run kdm
  include puppet-archlinux-macbookretina::kde

  # Install the mlocate package and run updatedb
  include puppet-archlinux-macbookretina::locate

  # Setup KDM/KDE specific to the MacBook Pro Retina - setup kdmrc
  include puppet-archlinux-macbookretina::mbp_retina_kde

  # Install default xorg.conf for MacBook Pro Retina
  include puppet-archlinux-macbookretina::mbp_retina_xorg

  # Install Mozilla ProfileManager for Firefox - https://developer.mozilla.org/en-US/docs/Profile_Manager
  include puppet-archlinux-macbookretina::mozilla_profilemanager

  # Install and setup networkmanager its KDE components, and ensure dhcpcd is stopped and nm is running
  include puppet-archlinux-macbookretina::networkmanager

  # Install nouveau driver for nvidia graphics
  include puppet-archlinux-macbookretina::nouveau

  # Install OpenVPN and its NetworkManager part
  include puppet-archlinux-macbookretina::openvpn

  # Sets up SSD-specific tuning on the system, disks and ext4 partitions
  include puppet-archlinux-macbookretina::ssd

  # Install and setup OpenSSH, drop in sshd_config
  include puppet-archlinux-macbookretina::sshd

  # Install sudoers file - Arch default plus allow wheel access to all (with password).
  include puppet-archlinux-macbookretina::sudoers

  # Install driver for Broadcom BCM4331 wireless, iw and wpa_supplicant
  include puppet-archlinux-macbookretina::wireless

  # Install packages required for xorg X server
  include puppet-archlinux-macbookretina::xorg

  # Add the archlinuxfr repo to pacman, install yaourt <https://wiki.archlinux.org/index.php/Yaourt> so we can get packages from AUR
  include puppet-archlinux-macbookretina::yaourt

}
