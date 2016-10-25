require 'spec_helper'

describe 'archlinux_macbookretina::touchpad' do
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
    it { should contain_class('archlinux_macbookretina::touchpad') }
    it { should contain_package('xf86-input-synaptics').with_ensure('present') }
    it { should contain_package('xf86-input-mtrack-git').with_ensure('absent') }
    it { should contain_file('/etc/X11/xorg.conf.d/00-touchpad.conf')
                 .with_ensure('present')
                 .with_owner('root')
                 .with_group('root')
                 .with_mode('0644')
                 .with_content(/Driver\s+"synaptics"/)
    }
  end
end
