# Class: archlinux_macbookretina::ssd
#
# Sets up SSD-specific tuning on the system, disks and ext4 partitions
#
# Parameters:
#
# Actions:
#   - make sure /dev/sda* is mounted with noatime, not relatime
#   - make sure /dev/sda* ext4 partitions are mounted with discard for TRIM
#   - set deadline scheduler on non-rotational disks via udev rule
#   - set sysctl vm.dirty_writeback_centisecs to 1500; slow down vm dirty page writes to disk
#   - set sysctl vm.laptop_mode to 5; dont really understand applicability for SSDs, but suggested by Arch docs
#   - set sysctl vm.swappiness to 1; decrease swapping to disk as much as possible
#   - set sysctl vm.vfs_cache_pressure to 50; kernel prefers to retain dir/inode caches longer, reduces reads
#
# Requires:
#   - duritong/sysctl puppet forge module for sysctl::value type
#
# Sample Usage:
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

  # sysctl values specific to laptops and SSDS
  #  see: https://www.kernel.org/doc/Documentation/sysctl/vm.txt
  #  and: https://www.kernel.org/doc/Documentation/laptops/laptop-mode.txt
  # TODO: commented out; will return to these later
  #sysctl::value {'vm.dirty_writeback_centisecs': value => '1500', }
  #sysctl::value {'vm.laptop_mode': value => '5', }
  #sysctl::value {'vm.swappiness': value => '1', }
  #sysctl::value {'vm.vfs_cache_pressure': value => '50', }

  # TODO - had to disable this, tests failing:
  # https://github.com/rodjek/rspec-puppet/issues/295#issuecomment-141514297
  # filter down to just SSD disks
  #$ssd_disks = filter($::disks) |$x| {
  #  $x[1]['model'] =~ /(?i:ssd)/
  #}

  # make sure relatime isn't specified on the /dev/sda mounts and noatime is
  # TODO: commented out until I have linux running on a machine to test this
  #fstab_replace_option {$ssd_partitions:
  #  old_option => 'relatime',
  #  option     => 'noatime',
  #}

  # since we're arch, we're going to assume you're on a recent kernel (at time of module writing)
  # TODO: commented out until I have linux running on a machine to test this
  #fstab_add_option {$ssd_partitions:
  #  option => 'discard',
  #  only_fstype => 'ext4',
  #}

}

