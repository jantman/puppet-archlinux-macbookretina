# Class: puppet-archlinux-macbookretina
#
# Manage includes of other puppet-archlinux-macbookretina classes
# top-level class for puppet-archlinux-macbookretina ecosystem
#
# Parameters:
#
# Actions:
#   - Include other classes
#
# Requires:
#
# Sample Usage:
#
class puppet-archlinux-macbookretina {
  # for i in `ls -1 *.pp | grep -v "init.pp" | awk -F \. '{print $1}'`; do echo "  include puppet-archlinux-macbookretina::$i"; done
  include puppet-archlinux-macbookretina::base
  include puppet-archlinux-macbookretina::kde
  include puppet-archlinux-macbookretina::nouveau
  include puppet-archlinux-macbookretina::sshd
  include puppet-archlinux-macbookretina::sudoers
  include puppet-archlinux-macbookretina::xorg
}
