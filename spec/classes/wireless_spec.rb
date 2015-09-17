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
      it { should contain_package('broadcom-wl').with_ensure('present') }
      it { should contain_package('iw').with_ensure('present') }
      it { should contain_package('wpa_supplicant').with_ensure('present') }
  end
end
