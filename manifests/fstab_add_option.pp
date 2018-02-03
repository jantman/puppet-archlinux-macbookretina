#
# Adds a specified option from /etc/fstab entry for a specified filesystem
#
# @param drive the filesystem specifier, first column in /etc/fstab; defaults to
#  the resource title.
# @param option the option to add
# @param only_fstype optional; only apply to mounts with this filesystem
#
define archlinux_macbookretina::fstab_add_option (
  String $option,
  String $drive = $title,
  String $only_fstype = ''
) {

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
      "ins opt after *[${spec}]/opt[last()]",
      "set *[${spec}]/opt[last()] ${option}",
    ],
    onlyif  => "match *[${spec} and count(opt[.='${option}'])=0] size > 0",
  }

}
