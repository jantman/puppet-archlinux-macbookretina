require 'spec_helper'

describe 'archlinux_macbookretina' do
  let(:facts) {{
    :osfamily        => 'Archlinux',
    :operatingsystem => 'Archlinux',
    :productname     => 'MacBookPro11,4',
    # structured facts
    :os              => { 'family' => 'Archlinux' },
    :dmi             => { 'product' => { 'name' => 'MacBookPro11,4' } },
  }}

  context 'supported operating systems' do
    describe "archlinux_macbookretina class with username parameter on Archlinux" do
      it { should compile.with_all_deps }
      it { should contain_class('archlinux_macbookretina') }
    end
  end

  context 'unsupported operating system' do
    describe 'archlinux_macbookretina class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
                     :osfamily        => 'Solaris',
                     :operatingsystem => 'Nexenta',
                     :productname     => 'MacBookPro11,4',
                     # structured facts
                     :os              => { 'family' => 'Solaris', 'name' => 'Nexenta', },
                     :dmi             => { 'product' => { 'name' => 'MacBookPro11,4' } },
      }}

      it { expect { should contain_class('archlinux_macbookretina') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
    describe 'archlinux_macbookretina class without any parameters on CentOS' do
      let(:facts) {{
                     :osfamily        => 'RedHat',
                     :operatingsystem => 'CentOS',
                     :productname     => 'MacBookPro11,4',
                     # structured facts
                     :os              => { 'family' => 'RedHat', 'name' => 'CentOS', },
                     :dmi             => { 'product' => { 'name' => 'MacBookPro11,4' } },
      }}

      it { expect { should contain_class('archlinux_macbookretina') }.to raise_error(Puppet::Error, /CentOS not supported/) }
    end
    describe 'archlinux_macbookretina class without any parameters on Debian' do
      let(:facts) {{
                     :osfamily        => 'Debian',
                     :operatingsystem => 'debian',
                     :productname     => 'MacBookPro11,4',
                     # structured facts
                     :os              => { 'family' => 'Debian', 'name' => 'debian', },
                     :dmi             => { 'product' => { 'name' => 'MacBookPro11,4' } },
      }}

      it { expect { should contain_class('archlinux_macbookretina') }.to raise_error(Puppet::Error, /debian not supported/) }
    end
  end

  context 'supported hardware' do
    describe 'MacBookPro10,1' do
      let(:facts) {{
                     :osfamily        => 'Archlinux',
                     :operatingsystem => 'Archlinux',
                     :productname     => 'MacBookPro10,1',
                     # structured facts
                     :os              => { 'family' => 'Archlinux' },
                     :dmi             => { 'product' => { 'name' => 'MacBookPro10,1' } },
      }}
      it { should compile.with_all_deps }
      it { should contain_class('archlinux_macbookretina') }
    end
    describe 'MacBookPro11,4' do
      let(:facts) {{
                     :osfamily        => 'Archlinux',
                     :operatingsystem => 'Archlinux',
                     :productname     => 'MacBookPro11,4',
                     # structured facts
                     :os              => { 'family' => 'Archlinux' },
                     :dmi             => { 'product' => { 'name' => 'MacBookPro11,4' } },
      }}
      it { should compile.with_all_deps }
      it { should contain_class('archlinux_macbookretina') }
    end
  end

  context 'unsupported hardware' do
    describe 'To be filled by O.E.M.' do
      let(:facts) {{
                     :osfamily        => 'Archlinux',
                     :operatingsystem => 'Archlinux',
                     :productname     => 'To be filled by O.E.M.',
                     # structured facts
                     :os              => { 'family' => 'Archlinux' },
                     :dmi             => { 'product' => { 'name' => 'To be filled by O.E.M.' } },
      }}
      it { expect { should contain_class('archlinux_macbookretina') }.to raise_error(Puppet::Error, /To be filled by O\.E\.M\. is not a supported hardware productname/) }
    end
  end
  context 'parameters' do
    describe 'default' do
      let(:facts) {{
                     :osfamily        => 'Archlinux',
                     :operatingsystem => 'Archlinux',
                     :productname     => 'MacBookPro11,4',
                     # structured facts
                     :os              => { 'family' => 'Archlinux' },
                     :dmi             => { 'product' => { 'name' => 'MacBookPro11,4' } },
      }}
      it { should compile.with_all_deps }
      it { should contain_class('archlinux_macbookretina') }
      it { should contain_class('archlinux_macbookretina::wireless') }
      it { should contain_class('archlinux_macbookretina::videodriver') }
    end
  end
end
