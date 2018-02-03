require 'puppet'

# helper to allow easy definition of a base set of facts for all specs
def spec_facts(additional = {})
  facts = {
    :osfamily        => 'Archlinux',
    :operatingsystem => 'Archlinux',
    :puppetversion   => Puppet::PUPPETVERSION,
    :virtual         => 'physical',
    :productname     => 'MacBookPro11,4',
    # structured facts
    :os              => { 'family' => 'Archlinux' },
    :dmi             => { 'product' => { 'name' => 'MacBookPro11,4' } },
    :disks           => {
      'sda' => {
        'model' => "APPLE SSD SM0256",
        'size' => "233.76 GiB",
        'size_bytes' => 251000193024,
        'vendor' => "ATA"
      },
      'sdb' => {
        'model' => "SD Card Reader",
        'size' => "0 bytes",
        'size_bytes' => 0,
        'vendor' => "APPLE"
      }
    }
  }
  facts.merge(additional)
end
