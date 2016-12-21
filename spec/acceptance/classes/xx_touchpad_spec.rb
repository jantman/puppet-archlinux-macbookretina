# This must run after the videodriver spec, as it needs xorg-server
require 'spec_helper_acceptance'

describe 'archlinux_macbookretina::touchpad class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'archlinux_macbookretina::touchpad': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('xf86-input-mtrack-git') do
      it { should_not be_installed }
    end

    describe package('xf86-input-synaptics') do
      it { should be_installed }
    end

    describe file('/etc/X11/xorg.conf.d/00-touchpad.conf') do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
      its(:content) { should match /Driver\s+"synaptics"/ }
    end
  end
end
