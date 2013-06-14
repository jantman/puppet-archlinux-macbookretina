#
# local_volumes.rb
#
# This fact provides an alphabetic list of local volumes that are currently
# available and/or accessible on the systems.
#
# This fact was initially written by Matt Moran and this implementation is
# simply an improvement upon it.
#
# from <https://github.com/kwilczynski/facter-facts/blob/master/local_volumes.rb>
#

require 'thread'
require 'facter'

if Facter.value(:kernel) == 'Linux'
  mutex = Mutex.new

  # We store the list of local volumes here ...
  volumes = []
  partitions_sda = []

  # Modern Linux distributions provide "df -lP" output in the following format:
  #
  #   Filesystem         1024-blocks      Used Available Capacity Mounted on
  #   /dev/hda1              5232640   3995212   1237428      77% /
  #   udev                     10240       116     10124       2% /dev
  #   /dev/hda2             41922560  33766468   8156092      81% /home
  #   shm                    1048712         0   1048712       0% /dev/shm
  #
  # Given "-P" command line switch enables POSIX compatibility and ensures
  # consistent format for output.
  #

  # We work-around an issue in Facter #10278 by forcing locale settings ...
  ENV['LANG']   = 'POSIX'
  ENV['LC_ALL'] = 'POSIX'

  #
  # We utilise rely on "cat" for reading values from entries under "/proc".
  # This is due to some problems with IO#read in Ruby and reading content of
  # the "proc" file system that was reported more than once in the past ...
  #
  Facter::Util::Resolution.exec('/bin/df -lP').each_line do |line|
    # Remove bloat ...
    line.strip!

    # Skip header line ...
    next if line.match(/^[Ff]ile.+/)

    # Skip new and empty lines ...
    next if line.match(/^(\r\n|\n|\s*)$|^$/)

    # Parse line and retrieve name of the local volume ...
    volume = line.split(' ')[5].strip

    # Add single volume to the list ...
    mutex.synchronize { volumes << volume }

    fs = line.split(' ')[0].strip

    next if not fs.match(/^\/dev\/sda.+$/)

    mutex.synchronize { partitions_sda << fs }
  end

  Facter.add('local_volumes') do
    confine :kernel => :linux
    setcode { volumes.sort.join(',') }
  end

  Facter.add('partitions_sda') do
    confine :kernel => :linux
    setcode { partitions_sda.sort.join(',') }
  end
end

# vim: set ts=2 sw=2 et :
# encoding: utf-8
