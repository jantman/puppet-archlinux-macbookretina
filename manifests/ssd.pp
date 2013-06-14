# Class: puppet-archlinux-macbookretina::ssd
#
# Sets up SSD-specific tuning on the system, disks and ext4 partitions
#
# Parameters:
#
# Actions:
#   - make sure /dev/sda* is mounted with noatime, not relatime
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::ssd {

  # this is a horrible hack, but I just can't find a better way to do it.
  # augeas' XPath queries don't handle globbing or regexes the way I want.
  # so we have to use a custom fact to find the mounted /dev/sda partitions
  # then (since facter only returns strings) split it, and pass the array
  # to create the define for each partition
  $ssd_partitions = split($::partitions_sda, ',')

  # make sure relatime isn't specified on the /dev/sda mounts
  fstab_remove_option {$ssd_partitions:
    option => 'relatime',
  }
  # and make sure they have noatime
  fstab_add_option {$ssd_partitions:
    option => 'noatime',
  }

  # since we're arch, we're going to assume you're on a recent kernel (at time of module writing)

}

