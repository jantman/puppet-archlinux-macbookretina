# Define: puppet-archlinux-macbookretina::fstab_replace_option
#
# Replace a specified option from /etc/fstab entry for a specified filesystem, with another option
#
# Parameters:
#
# $drive:: the filesystem specifier, first column in /etc/fstab
#
# $option:: string, the option to add
#
# $old_option:: string, the option to remove
#
# $only_fstype:: optional, string, only apply to mounts with this filesystem
#
# Actions:
#   - add a specified option for a specified filesystem in /etc/fstab
#
# Requires:
#
# Sample Usage:
#
define puppet-archlinux-macbookretina::fstab_replace_option ($drive = $title, $option, $old_option, $only_fstype = '') {

  # let us constrain to one fs type
  if $only_fstype == '' {
    $spec = "spec = '${drive}'"
  } else {
    $spec = "spec = '${drive}' and vfstype = '${only_fstype}'"
  }

  augeas {"sda_replace_remove_${old_option}_${drive}":
    context => '/files/etc/fstab',
    incl    => '/etc/fstab',
    lens    => 'fstab.lns',
    changes => [
      "rm *[$spec]/opt[.='$old_option']",
    ],
    onlyif  => "match *[$spec]/opt[.='$old_option'] size > 0",
  }

  augeas {"sda_replace_add_${option}_${drive}":
    context => '/files/etc/fstab',
    incl    => '/etc/fstab',
    lens    => 'fstab.lns',
    changes => [
      "ins opt after *[$spec]/opt[last()]",
      "set *[$spec]/opt[last()] $option",
    ],
    onlyif  => "match *[$spec and count(opt[.='$option'])=0] size > 0",
  }

}

