require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

hosts.each do |host|
  # Install Puppet
  install_puppet, opts={:version => '4.2.2'}
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # pacman update
    hosts.each do |h|
      on h, 'pacman -Syu'
    end
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'archlinux_macbookretina', :target_module_path => '/etc/puppetlabs/code/modules')
    moddir = 'spec/fixtures/modules/*'
    if not File.exist?(File.join(proj_root, 'spec/fixtures/modules/stdlib'))
      puts "ERROR: please run 'rake spec_prep' first"
      exit!(1)
    end
    Dir.glob(moddir).select {|f| File.directory?(f) and not File.symlink?(f)}.each do |dirname|
      dirpath = File.join(proj_root, dirname)
      modname = File.basename(dirname)
      puppet_module_install(:source => dirpath, :module_name => modname, :target_module_path => '/etc/puppetlabs/code/modules')
    end
    hosts.each do |h|
      on h, 'mkdir -p /etc/facter/facts.d'
    end
    scp_to(hosts, File.join(proj_root, 'spec', 'acceptance_test_fact_overrides.yaml'), '/etc/facter/facts.d/acceptance_test_overrides.yaml')
  end
end
