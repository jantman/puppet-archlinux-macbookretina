#
# Replace a specified option from /etc/fstab entry for a specified filesystem,
# with another option
#
# @param drive the filesystem specifier, first column in /etc/fstab; defaults to
#  the resource title.
# @param option the option to add
# @param old_option the option to remove
# @param only_fstype optional; only apply to mounts with this filesystem
#
define archlinux_macbookretina::fstab_replace_option (
  String $option,
  String $old_option,
  String $drive = $title,
  String $only_fstype = ''
) {

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
      "rm *[${spec}]/opt[.='${old_option}']",
    ],
    onlyif  => "match *[${spec}]/opt[.='${old_option}'] size > 0",
  }

  augeas {"sda_replace_add_${option}_${drive}":
    context => '/files/etc/fstab',
    incl    => '/etc/fstab',
    lens    => 'fstab.lns',
    changes => [
      "ins opt after *[${spec}]/opt[last()]",
      "set *[${spec}]/opt[last()] ${option}",
    ],
    onlyif  => "match *[${spec} and count(opt[.='${option}'])=0] size > 0",
  }

}
