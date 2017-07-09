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
* A pacman repo providing AUR packages: [macfanctld](https://aur.archlinux.org/packages/macfanctld), [bcwc-pcie-dkms](https://aur.archlinux.org/packages/bcwc-pcie-dkms/) and [bcwc-pcie-firmware](https://aur.archlinux.org/packages/bcwc-pcie-firmware/); you can use [jantman/archlinux_workstation archlinux_workstation::repos::jantman](https://github.com/jantman/puppet-archlinux-workstation/blob/master/manifests/repos/jantman.pp) for that.

Hardware Support Status
------------------------

### Mid-2015 MacBookPro11,4 as of 2016-10-25 (4.8.4-1 kernel)

#### Working

Or mostly-working:

* __Touchpad__ using Kernel 4.2+ and [xf86-input-synaptics](https://www.archlinux.org/packages/?name=xf86-input-synaptics); works for tap-to-click, drag, two-finger scroll, and 2- or 3-finger taps (sometimes) for different mouse buttons.
* __Networking__ on MacBookPro 11,4
  * USB ethernet adapter A1277 works out-of-the-box
  * BCM43602 AirPort Extreme (14e4:43ba) works with kernel built-in [brcmfmac](https://wireless.wiki.kernel.org/en/users/drivers/brcm80211) driver, autodetected, both 2.4GHz and 5GHz.
* __Sound__ - Works. Under KDE/Phonon, needed to unmute/enable the "Built-in Audio Analog Stereo" (detected "Built-in Audio Digital Stereo (HDMI)" as default).
* __Video__ - video works with the proprietary nvidia driver, the default in this module.
  * __External Displays__ - Tested OK using both direct HDMI and Thunderbolt to HDMI (1 or 2 external monitors); works seamlessly.
  * __Display/Desktop Scaling__ - This can be fixed within KDE:
    * System Settings -> Fonts: check off "Force fonts DIP" and set to 144
    * System Settings -> Icons -> "Advanced" tab: set them all to 48
    * Click the menu button on the far right edge of the Panel, then drag the "Height" box up until the scale/size looks good
  * __Screen Backlight Adjustment__ - works using ``/sys/class/backlight/acpi_video0/brightness``, the sliders on 'KDE5 System Settings -> Energy Saving' or the keyboard function keys.
* __Hibernate / Suspend to Disk__ - doesn't wake up without long hold of power button & then turn back on. Session resumes once that's done.
* __SD Card Reader__ - Working out of the box.
* __Fans__ - [macfanctld (AUR)](https://aur.archlinux.org/packages/macfanctld)
* __Webcam__ - Per [Arch Wiki](https://wiki.archlinux.org/index.php/MacBookPro11,x#Web_cam), there's a [project on GitHub](https://github.com/patjak/bcwc_pcie/) for a reverse-engineered driver. This works properly in Linux using the [bcwc-pcie-dkms](https://aur.archlinux.org/packages/bcwc-pcie-dkms/) and [bcwc-pcie-firmware](https://aur.archlinux.org/packages/bcwc-pcie-firmware/) AUR packages, though the color balance seems a bit off.

#### Broken

* __Suspend to RAM__ - doesn't wake up; long hold of power button & then turn back on gives a fresh boot.
* __Lid Close__ - suspends to ram and doesn't wake up
* __Bluetooth__ - Per [wiki](https://wiki.archlinux.org/index.php/MacBook#Bluetooth_2), fully supported as of kernel 4.4.0. Works with my bluetooth mouse.

#### Untested / To Do

* __Partially-complete__ - __SSD optimizations__ via sysctl settings, mount /dev/sda* noatime and discard (TRIM), use deadline scheduler on non-rotational disks
* __Power Saving__ - https://wiki.archlinux.org/index.php/MacBookPro11,x#Powersave and https://wiki.archlinux.org/index.php/Laptop_Mode_Tools
* [Laptop Mode Tools - ArchWiki](https://wiki.archlinux.org/index.php/Laptop_Mode_Tools) and/or  [TLP - ArchWiki](https://wiki.archlinux.org/index.php/TLP) *(started looking into this, very involved configuration and I don't really need it right now)*
* I'm left handed. Use udev/xorg to reverse buttons on USB mice but keep trackpad the same. See https://wiki.archlinux.org/index.php/All_Mouse_Buttons_Working http://www.smop.co.uk/blog/index.php/2010/02/15/udev-rules-for-logitech-g7-mouse/ or might be able to do this with udev triggering "xinput set-button-map"
* the stuff in [Maximizing Performance - ArchWiki](https://wiki.archlinux.org/index.php/Maximizing_Performance)
* implement the stuff in [Enhancing Arch Linux Stability - ArchWiki](https://wiki.archlinux.org/index.php/Enhancing_Arch_Linux_Stability)
* SMART/other SSD health check, with warnings if things go south
* look into replacing macfanctld with mbpfan / fan-control-daemon are two options that are less abrupt

Testing
-------

### Unit Tests

Unit tests should be run automatically by TravisCI. To run them locally, use ``bundle exec rake spec``. To run the full commit tests (validation, syntax, lint, rspec, etc.) use ``bundle exec rake test``.

1. Use whatever ruby version is specified in ``.ruby-version``
2. ``bundle install --path vendor``
3. ``bundle exec rake test``

### Acceptance Tests

Acceptance tests are done with [beaker](https://github.com/puppetlabs/beaker) and [beaker-rspec](https://github.com/puppetlabs/beaker-rspec). They currently use the "2017.07.01" version of the [ogarcia/archlinux-x64 Vagrant box](https://atlas.hashicorp.com/ogarcia/boxes/archlinux-x64/) for VirtualBox.

1. Use whatever ruby version is specified in ``.ruby-version``
2. ``bundle install --path vendor``
3. ``bundle exec rake spec_prep`` to setup the fixture modules that the specs will need
4. ``bundle exec rake beaker`` to run the tests.

See [beaker-rspec](https://github.com/puppetlabs/beaker-rspec) for environment variables to control the run. The important settings are:

* ``BEAKER_destroy=no`` - keep the VMs after the test run
* ``BEAKER_destroy=onpass`` - to keep the VMs around only after a test failure

Other References
----------------

* First, many thanks to [eli meister](https://twitter.com/elitmeister) for being the office linux-on-MBP retina guinea pig
* [MacBookPro Retina - ArchWiki](https://wiki.archlinux.org/index.php/MacBookPro_Retina)
* [MacBook - ArchWiki](https://wiki.archlinux.org/index.php/MacBook)
* [Installation Guide - ArchWiki](https://wiki.archlinux.org/index.php/Installation_Guide)
* [Beginners' Guide - ArchWiki](https://wiki.archlinux.org/index.php/Beginners%27_Guide)
* [Solid State Drives - ArchWiki](https://wiki.archlinux.org/index.php/Solid_State_Drives)
* [Laptop - ArchWiki](https://wiki.archlinux.org/index.php/Laptop)
* [Enhancing Arch Linux Stability - ArchWiki](https://wiki.archlinux.org/index.php/Enhancing_Arch_Linux_Stability)
* [Arch Linux System Maintenance - ArchWiki](https://wiki.archlinux.org/index.php/Arch_Linux_System_Maintenance)
