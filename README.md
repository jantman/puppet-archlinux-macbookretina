puppet-archlinux-macbookretina
==============================

Puppet module and accompanying documentation to install/setup Arch linux on a MacBook Pro Retina 10,1

This is the puppet module I use to manage my shiny new MacBook Pro Retina (10,1). My final setup will be Arch Linux, running KDM as the login/display manager and KDE4 as a desktop environment - though if you want something different, you can simply exclude those classes. 

I use Puppet to manage everything on my laptop after the initial configuration - packages, config files, etc.. For the intial configuration, I've documented my steps here.

Arch Installation
=================


Initial Configuration
=====================

Puppet Configuration
====================
* `mkdir /etc/puppet/modules; cd /etc/puppet/modules && git clone git://github.com/jantman/puppet-archlinux-macbookretina.git`
* `puppet apply --verbose --execute 'include puppet-archlinux-macbookretina'` (since we're just running a local apply)

