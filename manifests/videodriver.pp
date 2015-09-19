# Class: archlinux_macbookretina::videodriver
#
# Install driver for the MacBook Retina's NVidia graphics; either the
# proprietary nvidia driver, or the open source noveau driver. Remove
# whichever one isn't selected. Setup an xorg.conf file for it.
#
# Parameters:
#
# [*driver*]
#  String, either "nvidia" or "noveau", the one to install.
#  The other driver will be uninstalled. Defaults to the proprietary
#  "nvidia" per https://wiki.archlinux.org/index.php/MacBookPro11,x#Graphics
#
# Actions:
#   - Install nvidia or noveau drivers, and remove the other
#   - Install /etc/X11/xorg.conf with MBP Retina customization
#
class archlinux_macbookretina::videodriver (
  $driver = 'nvidia'
) {

  validate_re($driver, '^(nvidia|nouveau)$')

  $nouveau_packages = ['xf86-video-nouveau',  'nouveau-dri' ]
  # nvidia-bl is a backlight driver - https://aur.archlinux.org/packages/nvidia-bl/
  #  https://wiki.archlinux.org/index.php/MacBookPro11,x#Screen_backlight seems to
  #  indicate that this weird driver may not be needed anymore
  $nvidia_packages = [ 'nvidia' ]

  if $driver == 'nvidia' {
    $add_packages = $nvidia_packages
    $remove_packages = $nouveau_packages
  } else {
    $add_packages = $nouveau_packages
    $remove_packages = $nvidia_packages
  }

  package {$remove_packages :
    ensure          => absent,
    install_options => '-dds',
  } ->
  package {$add_packages :
    ensure  => present,
    # TODO: is this needed?
    #notify  => Exec['mkinitcpio'],
  }

  # TODO: temporarily comment out xorg.conf, see how much of this we need or if there's a better way to manage it
  #file { '/etc/X11/xorg.conf':
  #  ensure  => present,
  #  owner   => 'root',
  #  group   => 'root',
  #  mode    => '0644',
  #  source  => "puppet:///modules/archlinux_macbookretina/xorg.conf.${driver}",
  #}

}
