puppet-archlinux-macbookretina
==============================

Puppet module and accompanying documentation to install/setup Arch linux on a MacBook Pro Retina 10,1

This is the puppet module I use to manage my shiny new MacBook Pro Retina (10,1). My final setup will be Arch Linux, running KDM as the login/display manager and KDE4 as a desktop environment - though if you want something different, you can simply exclude those classes. 

I use Puppet to manage everything on my laptop after the initial configuration - packages, config files, etc.. For the intial configuration, I've documented my steps here.

If some of this seems overly verbose to experienced Arch users, this install is my first experience with Arch. I've jumped ship from Fedora (which I've always run, because I've always worked at RedHat/CentOS server shops, so it seemed logical), so it's taking me a while to adjust back to a desktop Linux that doesn't expect the user to be an idiot. This is also my first real foray into the new hotness in Puppet 3, so I'm playing around with that a bit too.

What Works
==========
This mainly relates to the hardware, but also includes some notes on the included puppet module:

* [suspend to RAM](https://wiki.archlinux.org/index.php/Suspend_to_RAM) works fine with Nouveau video driver (which I'm currently not using)
* USB ethernet adapter A1277
* Wireless networking using NetworkManager, including WPA
   * but getting dropped connections and `journalctl` showing `wl_cfg80211_get_station wrong mac address`
   * uses the wireless-broadcom-bcm43142 AUR package and DKMS, for our bcm4331 chipset
* Wired networking using NetworkManager and the USB ethernet adapter
* installing AUR packages via Yaourt (including in Puppet)
* [Chrony - ArchWiki](https://wiki.archlinux.org/index.php/Chrony) for NTP that plays well on a laptop
* iptables with rules provided by the puppetlabs firewall module
* makepkg set to compile and store source and logs under /tmp, which is by default a tmpfs in RAM sized at 50% of physical memory. If you need more space than that, see [Compiling in tmpfs](https://wiki.archlinux.org/index.php/Solid_State_Drives#Compiling_in_tmpfs)
* a bunch of userspace packages that I use
* SSD optimizations via sysctl settings, mount /dev/sda* noatime and discard (TRIM), use deadline scheduler on non-rotational disks
* [Profile-sync-daemon](https://wiki.archlinux.org/index.php/Profile-sync-daemon) to store browser profiles in memory (tmpfs) and periodically sync back to disk (disabled by default)
* install ksshaskpass and keychain
* fans work under macfanctld
* Video working under both Nouveau and Nvidia proprietary, though with some differences. Switching from one to the other does NOT work via Puppet, it's a manual task.
* Verizon Wireless/Novatel USB551L 3G/4G USB wireless dongle - works OOB with NetworkManager/ModemManager using the included USB cable adapter (adapter is required).
* [Vagrant](http://www.vagrantup.com/), [VirtualBox](https://www.virtualbox.org/) and the Oracle Virtualbox Extension Pack to get it to do VRDE, all installed via Puppet.
* [iSight](https://wiki.archlinux.org/index.php/MacBook#iSight) tested OK with Skype client
* Audio via builtin speakers and USB headset. HDMI untested so far.

Video Status (Nouveau vs Nvidia)
================================

|           | Nouveau | Nvidia |
| --------- | --------- | -------- |
| Monitor Backlight Adjustment | Works OOB | Doesnt work yet |
| Ext. Monitor Hot Plug | Doesn't work yet | Works w/ Puppetized configs |


What Doesnt Work (Yet)
======================
* Having issues after a `pacman -Syu` (package update), probably because I load kernels from `/boot/efi/EFI/arch` not `/boot`:
   * rEFInd is only seeing/giving options for `initramfs-linux-fallback.img` not `initramfs-linux.img`
   * when I upgraded from 3.9.6-1-ARCH to 3.9.8-1.ARCH, mkinitcpio failed because it was trying to generate against the OLD kernel (`[ALPM-SCRIPTLET] ==> Starting build: 3.9.6-1-ARCH`) which failed
   * because I keep kernels in the "wrong" place, the automated installation puts vmlinuz-linux/vmlinux in the wrong directory, which requires a manual copy
   * the result of all this is that after a straight upgrade/reboot, we fail with the following message, and have NO keyboard input working:

            :: Triggering uevents...
            Waiting 10 seconds for device /dev/disk/by-partuuid/957fddfa-df23-4501-adf1-5a39f2ea08a0 ...
            ERROR: device 'PARTUUID=957fddfa-df23-4501-adf1-5a39f2ea08a0' not found. Skipping fsck.
            ERROR: Unable to find root device 'PARTUUID=957fddfa-df23-4501-adf1-5a39f2ea08a0'.
            You are being dropped to a recovery shell
                Type 'exit' to try and continue booting
            sh: can't access tty: job control turned off
            [rootfs /]#

   * the output of the pacman linux update:

            [2013-07-02 06:54] [ALPM-SCRIPTLET] >>> Updating module dependencies. Please wait ...
            [2013-07-02 06:54] [ALPM-SCRIPTLET] >>> Generating initial ramdisk, using mkinitcpio.  Please wait...
            [2013-07-02 06:54] [ALPM-SCRIPTLET] ==> Building image from preset: /etc/mkinitcpio.d/linux.preset: 'default'
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> -k /boot/efi/EFI/arch/vmlinuz-linux -c /etc/mkinitcpio.conf -g /boot/efi/EFI/arch/initramfs-linux.img
            [2013-07-02 06:54] [ALPM-SCRIPTLET] ==> Starting build: 3.9.6-1-ARCH
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [base]
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [udev]
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [autodetect]
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [modconf]
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [block]
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [filesystems]
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [keyboard]
            [2013-07-02 06:54] [ALPM-SCRIPTLET] ==> ERROR: module not found: `usbhid'
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [fsck]
            [2013-07-02 06:54] [ALPM-SCRIPTLET] ==> WARNING: No modules were added to the image. This is probably not what you want.
            [2013-07-02 06:54] [ALPM-SCRIPTLET] ==> Creating gzip initcpio image: /boot/efi/EFI/arch/initramfs-linux.img
            [2013-07-02 06:54] [ALPM-SCRIPTLET] ==> WARNING: errors were encountered during the build. The image may not be complete.
            [2013-07-02 06:54] [ALPM-SCRIPTLET] ==> Building image from preset: /etc/mkinitcpio.d/linux.preset: 'fallback'
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> -k /boot/efi/EFI/arch/vmlinuz-linux -c /etc/mkinitcpio.conf -g /boot/efi/EFI/arch/initramfs-linux-fallback.img -S autodetect
            [2013-07-02 06:54] [ALPM-SCRIPTLET] ==> Starting build: 3.9.6-1-ARCH
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [base]
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [udev]
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [modconf]
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [block]
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [filesystems]
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [keyboard]
            [2013-07-02 06:54] [ALPM-SCRIPTLET] ==> ERROR: module not found: `usbhid'
            [2013-07-02 06:54] [ALPM-SCRIPTLET]   -> Running build hook: [fsck]
            [2013-07-02 06:54] [ALPM-SCRIPTLET] ==> WARNING: No modules were added to the image. This is probably not what you want.
            [2013-07-02 06:54] [ALPM-SCRIPTLET] ==> Creating gzip initcpio image: /boot/efi/EFI/arch/initramfs-linux-fallback.img
            [2013-07-02 06:54] [ALPM-SCRIPTLET] ==> WARNING: errors were encountered during the build. The image may not be complete.
            [2013-07-02 06:54] [PACMAN] upgraded linux (3.9.6-1 -> 3.9.8-1)
            [2013-07-02 06:54] [PACMAN] upgraded linux-headers (3.9.6-1 -> 3.9.8-1)

   * Possible resources for fixing this: [Unified Extensible Firmware Interface - ArchWiki](https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface#Fixing_errors), [MacBook - ArchWiki](https://wiki.archlinux.org/index.php/MacBook)
* Certain video/graphics related things, as seen in the section above.
* Hibernate to Disk (haven't set up a swap file yet, not sure I want to trade SSD writes for session persistence)
* [suspend to RAM](https://wiki.archlinux.org/index.php/Suspend_to_RAM) with Nvidia proprietary video driver version 319.23
   * There was a bug in nvidia 302 (https://bugs.archlinux.org/task/30330) but it was fixed in 304, so that shouldn't be the problem.
   * From [Ubuntu bug 488720](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/488720), "It turned out that commenting out a single line in the nvidia section of pm/sleep.d/98smart-kernel-video solved my issues. Dropping the chvt causes my X session to resume with garbled garbage.". This is a very long bug with lots of history, but there's also mention of an upstream bug in pm-utils (a much older version than we're running; 1.3.0), or needing to boot the kernel with 'nomodeset'. 
   * [NVidia DevTalk forum post on this from 2012-2013](https://devtalk.nvidia.com/default/topic/523257/linux-3-6-x-hybrid-suspend/), regarding driver versions ~313, reporting SSH running and working OK but can't resume X at all.
   * add "resume" to mkinitcpio HOOKS (before filesystems) and kernel command line???

Arch Installation
=================
What follows are NOT complete instructions, they are meant to be followed in parallel with the installation guide, and just provide some pointers, mainly relating to macbook/EFI specific stuff:

* in Mac OS X, shrink the single 250GB partition to 60GB, then install rEFInd
* boot the arch installer from USB flash drive
* `cgdisk`
  * create partitions - I setup a 1G HFS+ partition after MacOS, then separate ext4 partitions for root (/), home, var, and a spare ("mirror")
* `mkfs` on the partitions
* `mount` the partitions under /mnt
* this roughly follows the instructions at https://wiki.archlinux.org/index.php/Installation_Guide and https://wiki.archlinux.org/index.php/MacBook 
* `vim /etc/vconsole.conf` and append KEYMAP=qwerty
* `mkinitcpio -p linux`
* `passwd` (set root password)
* `pacman -S vim` (vi can't handle the giant resolution on the retina)
* `pacman -S grub-efi-x86_64 os-prober`
* `mkdir /boot/efi`
* `mount -t vfat /dev/sda1 /boot/efi`
* `add to /etc/fstab`
* `mkdir /boot/efi/EFI/refind`
* `pacman -S refind-efi`
* follow <https://wiki.archlinux.org/index.php/UEFI_Bootloaders#Setting_up_EFISTUB>
* edit `/boot/efi/EFI/refind/refind_linux.conf`, make sure the lines include add_efi_memmap
* didn't ` sudo bless --setBoot --folder /mnt/efi/EFI/refind --file /mnt/efi/EFI/refind/refind_x64.efi`
* `exit`
* `umount /mnt/{boot/efi,boot,home,mirror,var,}`
* `reboot`

Initial Configuration
=====================
These are the steps I took after I had a bootable system:

* login as root
* wired (USB adapter) ethernet with DHCP:
  * `systemctl enable dhcpcd@enp0s20u1`
  * `systemctl start dhcpcd@enp0s20u1`
* `pacman -S openssh`
* `vim /etc/ssh/sshd_config`, enable password auth, root login, RSA auth, PubKey auth (for now)
* `systemctl enable sshd; systemctl start sshd`
* ssh and login as root, complete the rest that way (I work a lot quicker from my keyboard and environment than on the laptop)
* `pacman -S base-devel`
* `vim /etc/makepkg.conf`, set "march=native" in CFLAGS and CXXFLAGS, set MAKEFLAGS -j8 (`nproc`)
* `useradd -m -g users -G audio,floppy,locate,lp,network,optical,power,storage,uucp,video,wheel -s /bin/bash USERNAME`
* `chfn -f "full name" USERNAME`
* `passwd USERNAME`
* `visudo` - uncomment wheel line
* re-login as user

At this point, I build my first Arch package from [AUR](https://aur.archlinux.org/), macfanctld:
* `mkdir ~/builds && cd ~/builds`
* `curl -o macfanctld-git.tar.gz https://aur.archlinux.org/packages/ma/macfanctld-git/macfanctld-git.tar.gz`
* `tar -xzvf macfanctld-git.tar.gz && cd macfanctld-git`
* `makepkg -s`
* `sudo pacman -U macfanctld-git-1-9-any.pkg.tar.xz`
* `systemctl start macfanctld.service && systemctl enable macfanctld.service`

Running macfanctld is relatively important, as out-of-the-box the macbook fans won't be turned on no matter the temperature. Once we've got that done, proceed with the rest of the installation (*NOTE* some of this is specific to KDE/KDM):

* `pacman -S xorg-server xorg-apps`
  * go with mesa-libgl for now
* `pacman -S xorg-server xorg-server-utils xorg-xinit mesa`
* `systemctl enable dhcpcd`
* `pacman -S xf86-video-nouveau`
* `Xorg :0 -configure`
* `mv /root/xorg.conf.new /etc/X11/xorg.conf`
* `pacman -S kdebase kdebase-workspace`
* `systemctl enable kdm.service`
* `cd ~/`
* build xf86-input-mtrack-git from AUR: https://aur.archlinux.org/packages/xf/xf86-input-mtrack-git/xf86-input-mtrack-git.tar.gz
* `curl -o retina.html https://wiki.archlinux.org/index.php/MacBookPro_Retina`
  * `vim retina.html`, strip out everything but the <pre> blocks around the touchpad X config (search for 'MatchIsTouchpad')
* `vim /etc/X11/xorg.conf`, paste in the snippet from above
* install from AUR: ruby-facter ruby-hiera ruby-hiera-json ruby-shadow ruby-rgen ruby-json_pure puppet
* from now on, the rest is handled with our Puppet configuration

Puppet Configuration
====================
* `mkdir /etc/puppet/modules; cd /etc/puppet/modules && git clone git://github.com/jantman/puppet-archlinux-macbookretina.git`
* `mkdir /etc/puppet/manifests; cp /etc/puppet/modules/puppet-archlinux-macbookretina/files/site.pp /etc/puppet/manifests`
* If you want to run [Profile-sync-daemon](https://wiki.archlinux.org/index.php/Profile-sync-daemon), edit `manifests/profilesyncdaemon.pp` and add your username in the $profile_sync_users string and uncomment the service entries. I have this disabled as my Firefox profile is 600+ MB and I don't want it all in RAM...
* `puppet apply --verbose /etc/puppet/manifests/site.pp` (since we're just running a local apply)
* once you have a successful run, reboot the machine so the changes to `/etc/fstab`, sysctl and `modprobe.conf` go into effect.

External Puppet Module Dependencies
-----------------------------------
* [duritong/sysctl · Puppet Forge](https://forge.puppetlabs.com/duritong/sysctl)
* [puppetlabs/firewall · Puppet Forge](https://forge.puppetlabs.com/puppetlabs/firewall)

To Do
=====

Initial Tasks for a working workstation
---------------------------------------
* get nouveau/nvidia switch to work - this currently fails, looks like pacman provider doesn't accept install_options
* [Laptop Mode Tools - ArchWiki](https://wiki.archlinux.org/index.php/Laptop_Mode_Tools) and/or  [TLP - ArchWiki](https://wiki.archlinux.org/index.php/TLP) *(started looking into this, very involved configuration and I don't really need it right now)*
   * https://wiki.archlinux.org/index.php/CPU_Frequency_Scaling#Laptop_Mode_Tools for cpu frequency scaling?
* I'm left handed. Use udev/xorg to reverse buttons on USB mice but keep trackpad the same. See https://wiki.archlinux.org/index.php/All_Mouse_Buttons_Working http://www.smop.co.uk/blog/index.php/2010/02/15/udev-rules-for-logitech-g7-mouse/ or might be able to do this with udev triggering "xinput set-button-map"
* pommed from AUR for keyboard mapping/function keys, with /etc/pommed.conf built from /etc/pommed.conf.mac; or other way of doing this
* keyboard backlight - /sys/class/leds/smc::kbd_backlight/brightness
* backlight adjustment - nvidia-bl, https://wiki.archlinux.org/index.php/MacBook#NVIDIA_note_2
* light sensor: https://wiki.archlinux.org/index.php/MacBook#Light_sensor

Second Round
------------

* hibernate to disk: https://wiki.archlinux.org/index.php/MacBook#Power_management *(I might give this up, as it just increases writes to the SSD...)*
* [Postfix - ArchWiki](https://wiki.archlinux.org/index.php/Local_Mail_Delivery_with_Postfix) for local delivery and relaying
* on Mac OS X side, mute the startup chime if you want: `/usr/bin/nvram SystemAudioVolume=%01`
* the stuff in [Maximizing Performance - ArchWiki](https://wiki.archlinux.org/index.php/Maximizing_Performance)
* implement the stuff in [Enhancing Arch Linux Stability - ArchWiki](https://wiki.archlinux.org/index.php/Enhancing_Arch_Linux_Stability)
* Administration tasks - figure out how to automate
   * pacman update reminders, reminder to check output (log it somewhere? mail the log?), reminder to update AUR/yaourt packages
   * `pacman -Qdt` to find orphaned packages
   * find `*.pacnew` and `*.pacsave` config files
   * check for out-of-date/unmaintained AUR packages
   * SMART/other SSD health check, with warnings if things go south
   * figure out a nice, simple way to handle backups of a laptop that's often suspended on nights/weekends
* further [KDE - ArchWiki](https://wiki.archlinux.org/index.php/Kde) configuration
* other userspace applications
   * opera
   * kdegraphics-gwenview
   * gimp
   * imagemagick
   * dia
   * kdegraphics-ksnapshot
   * scrot
   * vlc
   * nmap
   * wireshark-cli
   * wireshark-gtk
   * tcpdump
   * rsnapshot
* IP stack hardening [sysctl - ArchWiki](https://wiki.archlinux.org/index.php/Sysctl#TCP.2FIP_stack_hardening) - see also [thias/sysctl · Puppet Forge](https://forge.puppetlabs.com/thias/sysctl)
* look into replacing macfanctld with mbpfan / fan-control-daemon are two options that are less abrupt
* figure out why `facter` is having problems getting ipaddress, macaddress, networkmask
* figure out why wireless keeps dropping connection with `wl_cfg80211_get_station wrong mac address`
* puppet pacman provider - keeps reinstalling metapackages (kdebase, xorg-apps)
* add a TOC to this README.md - [aslushnikov/table-of-contents-preprocessor · GitHub](https://github.com/aslushnikov/table-of-contents-preprocessor)
* generate puppetdoc docs for all of this
* setup color profiles: https://wiki.archlinux.org/index.php/MacBook#Color_Profile
* setup LiRC and an apple remote: https://wiki.archlinux.org/index.php/MacBook#Apple_Remote
* [Pdnsd - ArchWiki](https://wiki.archlinux.org/index.php/Pdnsd) for local DNS caching *(started work on this, not sure how it will play nicely with NetworkManager/often-changing DNS configs on a laptop, also not sure if I want DNS cached locally)*
* make mozilla-profilemanager an AUR package, not this awful exec-based stuff
* ip6tables
* [AUR (en) - anything-sync-daemon](https://aur.archlinux.org/packages/anything-sync-daemon/) to store high write activity user directories in tmpfs

Other References
================
* First, many thanks to [eli meister](https://twitter.com/elitmeister) for being the office linux-on-MBP retina guinea pig
* [MacBookPro Retina - ArchWiki](https://wiki.archlinux.org/index.php/MacBookPro_Retina)
* [MacBook - ArchWiki](https://wiki.archlinux.org/index.php/MacBook)
* [Installation Guide - ArchWiki](https://wiki.archlinux.org/index.php/Installation_Guide)
* [Beginners' Guide - ArchWiki](https://wiki.archlinux.org/index.php/Beginners%27_Guide)
* [Solid State Drives - ArchWiki](https://wiki.archlinux.org/index.php/Solid_State_Drives)
* [Laptop - ArchWiki](https://wiki.archlinux.org/index.php/Laptop)
* [Enhancing Arch Linux Stability - ArchWiki](https://wiki.archlinux.org/index.php/Enhancing_Arch_Linux_Stability)
* [Arch Linux System Maintenance - ArchWiki](https://wiki.archlinux.org/index.php/Arch_Linux_System_Maintenance)
* journalctl, systemd's syslog replacement: [systemd - ArchWiki](https://wiki.archlinux.org/index.php/Systemd#Journal)
