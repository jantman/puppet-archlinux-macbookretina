puppet-archlinux-macbookretina
==============================

Puppet module and accompanying documentation to install/setup Arch linux on a MacBook Pro Retina 10,1

This is the puppet module I use to manage my shiny new MacBook Pro Retina (10,1). My final setup will be Arch Linux, running KDM as the login/display manager and KDE4 as a desktop environment - though if you want something different, you can simply exclude those classes. 

I use Puppet to manage everything on my laptop after the initial configuration - packages, config files, etc.. For the intial configuration, I've documented my steps here.

If some of this seems overly verbose to experienced Arch users, this install is my first experience with Arch. I've jumped ship from Fedora (which I've always run, because I've always worked at RedHat/CentOS server shops, so it seemed logical), so it's taking me a while to adjust back to a desktop Linux that doesn't expect the user to be an idiot.

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
* `puppet apply --verbose --execute 'include puppet-archlinux-macbookretina'` (since we're just running a local apply)

To Do
=====
* try proprietary nvidia driver? (UseDPLibs Off, no brightness control currently)
* fnmode - options hid_apple fnmode=2 in modprobe.conf.d
* dpi - add -dpi 156   to ServerArgLocal in /usr/share/config/kdm/kdmrc
* wireless - wireless-broadcom-bcm43142 in arch, anything based on broadcom 6.20.155.1-8 driver instead of 5.xx (fwcutter with 6.x may work with b43, did not try)
* look into replacing macfanctld with mbpfan / fan-control-daemon are two options that are less abrupt

Other References
================
* First, many thanks to [eli meister](https://twitter.com/elitmeister) for being the office linux-on-MBP retina guinea pig
* [MacBook - ArchWiki](https://wiki.archlinux.org/index.php/MacBook)
* [Installation Guide - ArchWiki](https://wiki.archlinux.org/index.php/Installation_Guide)
* [Beginners' Guide - ArchWiki](https://wiki.archlinux.org/index.php/Beginners%27_Guide)
* [Solid State Drives - ArchWiki](https://wiki.archlinux.org/index.php/Solid_State_Drives)
* [Laptop - ArchWiki](https://wiki.archlinux.org/index.php/Laptop)
* [Enhancing Arch Linux Stability - ArchWiki](https://wiki.archlinux.org/index.php/Enhancing_Arch_Linux_Stability)
* [Arch Linux System Maintenance - ArchWiki](https://wiki.archlinux.org/index.php/Arch_Linux_System_Maintenance)

