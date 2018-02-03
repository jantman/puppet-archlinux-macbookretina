require 'spec_helper'

describe 'archlinux_macbookretina::wireless' do
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
      it { should contain_package('iw').with_ensure('present') }
      it { should contain_package('wpa_supplicant').with_ensure('present') }
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
    it { should contain_package('broadcom-wl').with_ensure('present') }
  end
  describe 'uses kernel builtin drivers on MBP 11,4' do
    let(:facts) {{
                   :osfamily        => 'Archlinux',
                   :operatingsystem => 'Archlinux',
                   :productname     => 'MacBookPro11,4',
                   # structured facts
                   :os              => { 'family' => 'Archlinux' },
                   :dmi             => { 'product' => { 'name' => 'MacBookPro11,4' } },
                 }}
    it { should_not contain_package('broadcom-wl') }
    it { should contain_notify('using built-in kernel drivers for wireless on MacBookPro11,4') }
  end
end
