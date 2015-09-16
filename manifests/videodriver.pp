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

  $nouveau_packages = ['xf86-video-nouveau',  'nouveau-dri', 'mesa-libgl', 'lib32-mesa-libgl' ]
  $nvidia_packages = [ 'nvidia', 'nvidia-bl' ]

  if $driver == 'nvidia' {
    $add_packages = $nvidia_packages
    $remove_packages = $nouveau_packages
  } else {
    $add_packages = $nouveau_packages
    $remove_packages = $nvidia_packages
  }

  package {$remove_packages :
    install_options => '-dds',
    ensure          => absent,
  } ->
  package {$add_packages :
    ensure  => present,
    #notify  => Exec['mkinitcpio'],
  }

  #file { '/etc/X11/xorg.conf':
  #  ensure  => present,
  #  owner   => 'root',
  #  group   => 'root',
  #  mode    => '0644',
  #  source  => "puppet:///modules/archlinux_macbookretina/xorg.conf.${driver}",
  #}

}
