#
# Sets up SSD-specific tuning on the system.
#
# Currently only writes ``/etc/udev/rules.d/60-schedulers.rules`` to set rotational
# disks (non-SSD) to use the CFQ scheduler, and non-rotational (SSD) to use
# the deadline scheduler.
#
class archlinux_macbookretina::ssd {

  # CFQ is a *bad* scheduler for SSD. let's tell udev that we want to use deadline instead
  file {'/etc/udev/rules.d/60-schedulers.rules':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/archlinux_macbookretina/60-schedulers.rules',
  }

}
