# Class: puppet-archlinux-macbookretina::libreoffice
#
# Install LibreOffice suite
#
# Parameters:
#
# Actions:
#   - Install libreoffice packages
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::libreoffice {

  $libreoffice_packages = ['libreoffice-base', 'libreoffice-calc', 'libreoffice-common', 'libreoffice-draw', 'libreoffice-extension-nlpsolver', 'libreoffice-extension-presentation-minimizer', 'libreoffice-impress', 'libreoffice-kde4', 'libreoffice-math', 'libreoffice-writer', 'libreoffice-en-US']

  package {$libreoffice_packages:
    ensure  => present,
  }

}
