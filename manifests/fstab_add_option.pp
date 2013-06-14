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
# Actions:
#   - add a specified option for a specified filesystem in /etc/fstab
#
# Requires:
#
# Sample Usage:
#
define puppet-archlinux-macbookretina::fstab_add_option ($drive = $title, $option) {

  augeas {"sda_add_${option}_${drive}":
    context => '/files/etc/fstab',
    incl    => '/etc/fstab',
    lens    => 'fstab.lns',
    changes => [
      "ins opt after *[spec='$drive']/opt[last()]",
      "set *[spec='$drive']/opt[last()] $option",
    ],
    onlyif  => "match *[spec = '$drive']/opt[.='$option'] size < 1",
  }

}

