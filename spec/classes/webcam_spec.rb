require 'spec_helper'

describe 'archlinux_macbookretina::webcam' do
  let(:facts) { spec_facts }

  describe "installs packages" do
      it { should compile.with_all_deps }
      it { should contain_package('bcwc-pcie-git').with_ensure('present') }
      it { should contain_package('facetimehd-firmware').with_ensure('present') }
  end
  describe 'uses broadcom-wl on MBP 10,1' do
    let(:facts) { spec_facts(
      :productname     => 'MacBookPro10,1',
      :dmi             => { 'product' => { 'name' => 'MacBookPro10,1' } },
    ) }

   it { should compile.with_all_deps }
   it { should_not contain_package('bcwc-pcie-git') }
   it { should_not contain_package('facetimehd-firmware') }
   it { should contain_notify('archlinux_macbookretina does not know how to configure webcam on: MacBookPro10,1') }
  end
end
