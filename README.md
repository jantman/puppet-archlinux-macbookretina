archlinux_macbookretina puppet module
=====================================

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)

Puppet module and accompanying documentation to install/setup Arch linux on a MacBook Pro Retina using puppet4.

This is the puppet module I use to manage my shiny new MacBook Pro Retina (mine is a ``MacBookPro11,4``).

__Important Notice:__ It is _highly_ recommended that you only run this module on a brand new system;
it makes some opinionated choices that may cause problems on existing systems.

Requirements
------------

* A MacBook Pro Retina (currently tested with Mid-2015 "11,4" model) with a __brand new install__ of Arch Linux
* Puppet4
* A minimal install, ideally following the instructions in my [workstation-bootstrap](https://github.com/jantman/workstation-bootstrap#arch-linux) repository.
* This module is only tested alongside my [archlinux_workstation](https://github.com/jantman/puppet-archlinux-workstation) module.
* A pacman repo providing ``xf86-input-mtrack-git``; you can use [jantman/archlinux_workstation archlinux_workstation::repos::jantman](https://github.com/jantman/puppet-archlinux-workstation/blob/master/manifests/repos/jantman.pp) for that.

Hardware Support Status
------------------------

### Mid-2015 MacBookPro11,4

#### Working

Or mostly-working:

* __Networking__
  * USB ethernet adapter A1277 works out-of-the-box
  * BCM43602 AirPort Extreme (14e4:43ba) works with kernel built-in [brcmfmac](https://wireless.wiki.kernel.org/en/users/drivers/brcm80211) driver, autodetected, but __2.4GHz only__
* __Sound__ - Works. Under KDE/Phonon, needed to unmute/enable the "Built-in Audio Analog Stereo" (detected "Built-in Audio Digital Stereo (HDMI)" as default).
* __Video__ - video works with the proprietary nvidia driver, the default in this module.
  * __External Displays__ - Tested OK using both direct HDMI and Thunderbolt to HDMI; works seamlessly.
  * __Video during suspend/hibernate__ - 
  * __Display/Desktop Scaling__ - This can be fixed within KDE:
    * System Settings -> Fonts: check off "Force fonts DIP" and set to 144
    * System Settings -> Icons -> "Advanced" tab: set them all to 48
    * Click the menu button on the far right edge of the Panel, then drag the "Height" box up until the scale/size looks good
  * __Screen Backlight Adjustment__ - https://wiki.archlinux.org/index.php/MacBookPro11,x#Screen_backlight
* __Hibernate / Suspend to Disk__ - doesn't wake up without long hold of power button & then turn back on. Session resumes once that's done.

#### Broken

* __Touchpad__ - Per the [wiki](https://wiki.archlinux.org/index.php/MacBook#Early_2015_13.22.2F15.22_-_Version_12.2Cx.2F11.2C4.2B), the touchpad isn't supported until kernel 4.2.x, with ``xf86-input-synaptics``. Until then, cursor and click works, but no right-click or scroll. I tried both [xf86-input-multitouch-git](https://aur.archlinux.org/packages/xf86-input-multitouch-git/) and [xf86-input-synaptics](https://www.archlinux.org/packages/?name=xf86-input-synaptics) and neither helped this.
* __Webcam__ - Per [Arch Wiki](https://wiki.archlinux.org/index.php/MacBookPro11,x#Web_cam), there's no driver for this yet. There's a [project on GitHub](https://github.com/patjak/bcwc_pcie/) but it (2015-09-18) isn't working yet.
* __Suspend to RAM__ - doesn't wake up; long hold of power button & then turn back on gives a fresh boot.
* __Lid Close__ - suspends to ram and doesn't wake up
* __Bluetooth__ - Per [wiki](https://wiki.archlinux.org/index.php/MacBook#Bluetooth_2), "not working at all"; even though ``dmesg`` shows that the bluetooth controller is recognized, my tests seem to confirm that it doesn't work.

#### Untested

* __not yet done__ - __makepkg__ set to compile and store source and logs under /tmp, which is by default a tmpfs in RAM sized at 50% of physical memory. If you need more space than that, see [Compiling in tmpfs](https://wiki.archlinux.org/index.php/Solid_State_Drives#Compiling_in_tmpfs)
* __not yet done__ - __SSD optimizations__ via sysctl settings, mount /dev/sda* noatime and discard (TRIM), use deadline scheduler on non-rotational disks
* __not yet done__ - [Profile-sync-daemon](https://wiki.archlinux.org/index.php/Profile-sync-daemon) to store browser profiles in memory (tmpfs) and periodically sync back to disk (disabled by default)
* __not yet done__fans work under macfanctld
* __Keyboard Backlight__ - https://wiki.archlinux.org/index.php/MacBookPro11,x#Keyboard_backlight
* __SD Card Reader__ - https://wiki.archlinux.org/index.php/MacBookPro11,x#SD_Card_Reader
* __Power Saving__ - https://wiki.archlinux.org/index.php/MacBookPro11,x#Powersave
* __Ctrl-Click as Right Click__ - http://superuser.com/questions/217615/how-to-right-click-using-the-keyboard-from-ubuntu-on-a-mac
* __Light Sensor__ - https://github.com/poliva/lightum

To Do
=====

* [Laptop Mode Tools - ArchWiki](https://wiki.archlinux.org/index.php/Laptop_Mode_Tools) and/or  [TLP - ArchWiki](https://wiki.archlinux.org/index.php/TLP) *(started looking into this, very involved configuration and I don't really need it right now)*
   * https://wiki.archlinux.org/index.php/CPU_Frequency_Scaling#Laptop_Mode_Tools for cpu frequency scaling?
* I'm left handed. Use udev/xorg to reverse buttons on USB mice but keep trackpad the same. See https://wiki.archlinux.org/index.php/All_Mouse_Buttons_Working http://www.smop.co.uk/blog/index.php/2010/02/15/udev-rules-for-logitech-g7-mouse/ or might be able to do this with udev triggering "xinput set-button-map"
* pommed from AUR for keyboard mapping/function keys, with /etc/pommed.conf built from /etc/pommed.conf.mac; or other way of doing this
* backlight adjustment - nvidia-bl, https://wiki.archlinux.org/index.php/MacBook#NVIDIA_note_2
* light sensor: https://wiki.archlinux.org/index.php/MacBook#Light_sensor
* hibernate to disk: https://wiki.archlinux.org/index.php/MacBook#Power_management *(I might give this up, as it just increases writes to the SSD...)*
* the stuff in [Maximizing Performance - ArchWiki](https://wiki.archlinux.org/index.php/Maximizing_Performance)
* implement the stuff in [Enhancing Arch Linux Stability - ArchWiki](https://wiki.archlinux.org/index.php/Enhancing_Arch_Linux_Stability)
 SMART/other SSD health check, with warnings if things go south
* further [KDE - ArchWiki](https://wiki.archlinux.org/index.php/Kde) configuration
* IP stack hardening [sysctl - ArchWiki](https://wiki.archlinux.org/index.php/Sysctl#TCP.2FIP_stack_hardening) - see also [thias/sysctl · Puppet Forge](https://forge.puppetlabs.com/thias/sysctl)
* look into replacing macfanctld with mbpfan / fan-control-daemon are two options that are less abrupt
* setup color profiles: https://wiki.archlinux.org/index.php/MacBook#Color_Profile
* [Pdnsd - ArchWiki](https://wiki.archlinux.org/index.php/Pdnsd) for local DNS caching *(started work on this, not sure how it will play nicely with NetworkManager/often-changing DNS configs on a laptop, also not sure if I want DNS cached locally)*
* make mozilla-profilemanager an AUR package, not this awful exec-based stuff
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
