# Define: puppet-archlinux-macbookretina::fstab_remove_option
#
# Removes a specified option from /etc/fstab entry for a specified filesystem
#
# Parameters:
#
# $drive:: the filesystem specifier, first column in /etc/fstab
#
# $option:: string, the option to remove
#
# $only_fstype:: optional, string, only apply to mounts with this filesystem
#
# Actions:
#   - remove a specified option for a specified filesystem in /etc/fstab
#
# Requires:
#
# Sample Usage:
#
define puppet-archlinux-macbookretina::fstab_remove_option ($drive = $title, $option, $only_fstype = '') {

  # let us constrain to one fs type
  if $only_fstype == '' {
    $spec = "spec = '${drive}'"
  } else {
    $spec = "spec = '${drive}' and vfstype = '${only_fstype}'"
  }

  augeas {"sda_remove_${option}_${drive}":
    context => '/files/etc/fstab',
    incl    => '/etc/fstab',
    lens    => 'fstab.lns',
    changes => [
      "rm *[$spec]/opt[.='$option']",
    ],
    onlyif  => "match *[$spec]/opt[.='$option'] size > 0",
  }

}

