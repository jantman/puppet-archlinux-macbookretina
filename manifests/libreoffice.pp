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

  $libreoffice_packages = ['libreoffice-base', 'libreoffice-calc', 'libreoffice-common', 'libreoffice-draw', 'libreoffice-extension-npsolver', 'libreoffice-extension-presentation-minimizer', 'libreoffice-extension-report-builder', 'libreoffice-impress', 'libreoffice-kde4', 'libreoffice-math', 'libreoffice-writer']

  package {$libreoffice_packages:
    ensure  => present,
  }

}
