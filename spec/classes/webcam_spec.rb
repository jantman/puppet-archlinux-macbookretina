require 'spec_helper'

describe 'archlinux_macbookretina::webcam' do
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
      it { should contain_package('bcwc-pcie-dkms').with_ensure('present') }
      it { should contain_package('bcwc-pcie-firmware').with_ensure('present') }
  end
  describe 'uses broadcom-wl on MBP 10,1' do
    let(:facts) {{
                   :osfamily        => 'Archlinux',
                   :operatingsystem => 'Archlinux',
                   :productname     => 'MacBookPro10,1',
                   # structured facts
                   :os              => { 'family' => 'Archlinux' },
                   :dmi             => { 'product' => { 'name' => 'MacBookPro10,1' } },
                 }}
   it { should compile.with_all_deps }
   it { should_not contain_package('bcwc-pcie-dkms') }
   it { should_not contain_package('bcwc-pcie-firmware') }
  end
end
