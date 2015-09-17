require 'spec_helper'

describe 'archlinux_macbookretina::mac_keyboard' do
  let(:facts) {{
    :osfamily        => 'Archlinux',
    :operatingsystem => 'Archlinux',
    :productname     => 'MacBookPro11,4',
    # structured facts
    :os              => { 'family' => 'Archlinux' },
    :dmi             => { 'product' => { 'name' => 'MacBookPro11,4' } },
  }}

  describe "creates file" do
      it { should compile.with_all_deps }
      it { should contain_file('/etc/modprobe.d/apple.conf')
                   .with({
                           :ensure => 'present',
                           :owner  => 'root',
                           :group  => 'root',
                           :mode   => '0644',
                           :source => 'puppet:///modules/archlinux_macbookretina/apple.conf',
                         })
      }
  end
end
