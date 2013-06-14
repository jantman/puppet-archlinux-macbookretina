# Define: puppet-archlinux-macbookretina::fstab_add_option
#
# Adds a specified option from /etc/fstab entry for a specified filesystem
#
# Parameters:
#
# $drive:: the filesystem specifier, first column in /etc/fstab
#
# $option:: string, the option to add
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
define puppet-archlinux-macbookretina::fstab_add_option ($drive = $title, $option, $only_fstype = '') {

  # let us constrain to one fs type
  if $only_fstype == '' {
    $spec = "spec = '${drive}'"
  } else {
    $spec = "spec = '${drive}' and vfstype = '${only_fstype}'"
  }

  augeas {"sda_add_${option}_${drive}":
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

