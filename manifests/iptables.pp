# Class: puppet-archlinux-macbookretina::iptables
#
# Install iptables and setup framework for puppetlabs/firewall module and set custom rules
#
# For more information, see:
#   - [iptables - ArchWiki](https://wiki.archlinux.org/index.php/Iptables)
#   - [puppetlabs/firewall · Puppet Forge](https://forge.puppetlabs.com/puppetlabs/firewall)
#
# Parameters:
#
# Actions:
#   - Setup /etc/conf.d/iptables
#   - Set firewall pre and post hook classes
#   - Instantiate firewall_pre and firewall_post classes
#   - Instantiate firewall class
#
# Requires:
#   - puppetlabs/firewall module from puppet forge
#
# Sample Usage:
#
class puppet-archlinux-macbookretina::iptables {

  # this file needs to be in place before anything else, to tell iptables where to save/restore rules to/from
  file {'/etc/conf.d/iptables':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet-archlinux-macbookretina/confd_iptables',
  }

  #
  # CUSTOM RULES go below here or in other classes
  #


}
