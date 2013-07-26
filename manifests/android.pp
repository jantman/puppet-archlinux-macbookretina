# Class: puppet-archlinux-macbookretina::android
#
# Install Android development tools
#
# Parameters:
#
# Actions:
#   - Install android development tools
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::android {

  package {'android-sdk':
    ensure => present,
  }

  package {'android-sdk-platform-tools':
    ensure => present,
  }

  package {'android-2.3':
    ensure => present,
  }

}
