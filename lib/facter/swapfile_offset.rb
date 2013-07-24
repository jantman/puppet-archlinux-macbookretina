#
# swapfile_offset.rb
#
# This fact provides the filesystem offset of /swapfile if it exists.
#

require 'facter'

if Facter.value(:kernel) == 'Linux'

  # output looks something like:
  #[root@jarvis boot]# filefrag -v /swapfile | head -10
  #Filesystem type is: ef53
  #File size of /swapfile is 4294967296 (1048576 blocks of 4096 bytes)
  # ext:     logical_offset:        physical_offset: length:   expected: flags:
  #   0:        0..       0:     509952..    509952:      1:
  #   1:        1..    2047:     509953..    511999:   2047:             unwritten
  #   2:     2048..    4095:     512000..    514047:   2048:             unwritten
  #   3:     4096..    6143:     514048..    516095:   2048:             unwritten
  #   4:     6144..    8191:     520192..    522239:   2048:     516096: unwritten
  #   5:     8192..   10239:     522240..    524287:   2048:             unwritten
  #   6:    10240..   12287:     778240..    780287:   2048:     524288: unwritten
  #

  # We work-around an issue in Facter #10278 by forcing locale settings ...
  ENV['LANG']   = 'POSIX'
  ENV['LC_ALL'] = 'POSIX'

  if FileTest.exists?("/swapfile") do

    Facter::Util::Resolution.exec('/usr/bin/filefrag -v /swapfile').each_line do |line|
      # Remove bloat ...
      line.strip!

      # Skip header line ...
      next if not line.match(/^0:+/)

      # Parse line and retrieve offset...
      offset = line.split(' ')[3].strip

      Facter.add('swapfile_offset') do
        confine :kernel => :linux
        setcode { offset }
      end

    end

  end

end
end
# vim: set ts=2 sw=2 et :
# encoding: utf-8
