require 'spec_helper'

describe 'archlinux_macbookretina::ssd' do
  let(:facts) {{
    :osfamily        => 'Archlinux',
    :operatingsystem => 'Archlinux',
    :productname     => 'MacBookPro11,4',
    # structured facts
    :os              => { 'family' => 'Archlinux' },
    :dmi             => { 'product' => { 'name' => 'MacBookPro11,4' } },
  }}

  describe "installs packages" do
    it { should compile.with_all_deps }
    it { should contain_class('archlinux_macbookretina::ssd') }
    it { should contain_file('/etc/udev/rules.d/60-schedulers.rules').with({
                                                                           :ensure => 'present',
                                                                           :owner  => 'root',
                                                                           :group  => 'root',
                                                                           :mode   => '0644',
                                                                           :source => 'puppet:///modules/archlinux_macbookretina/60-schedulers.rules',
                                                                           })
    }

    it { should_not contain_sysctl__value('vm.dirty_writeback_centisecs') }
    it { should_not contain_sysctl__value('vm.laptop_mode') }
    it { should_not contain_sysctl__value('vm.swappiness') }
    it { should_not contain_sysctl__value('vm.vfs_cache_pressure') }
  end
end
