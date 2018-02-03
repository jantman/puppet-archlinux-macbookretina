require 'spec_helper'

describe 'archlinux_macbookretina' do
  let(:facts) { spec_facts }

  context 'supported operating systems' do
    describe "archlinux_macbookretina class with username parameter on Archlinux" do
      it { should compile.with_all_deps }
      it { should contain_class('archlinux_macbookretina') }
    end
  end

  context 'unsupported operating system' do
    describe 'archlinux_macbookretina class without any parameters on Solaris/Nexenta' do
      let(:facts) { spec_facts(
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
        :os              => { 'family' => 'Solaris', 'name' => 'Nexenta', },
      ) }

      it { expect { should contain_class('archlinux_macbookretina') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
    describe 'archlinux_macbookretina class without any parameters on CentOS' do
      let(:facts) { spec_facts(
        :osfamily        => 'RedHat',
        :operatingsystem => 'CentOS',
        # structured facts
        :os              => { 'family' => 'RedHat', 'name' => 'CentOS', },
      ) }

      it { expect { should contain_class('archlinux_macbookretina') }.to raise_error(Puppet::Error, /CentOS not supported/) }
    end
    describe 'archlinux_macbookretina class without any parameters on Debian' do
      let(:facts) { spec_facts(
        :osfamily        => 'Debian',
        :operatingsystem => 'debian',
        # structured facts
        :os              => { 'family' => 'Debian', 'name' => 'debian', },
      ) }

      it { expect { should contain_class('archlinux_macbookretina') }.to raise_error(Puppet::Error, /debian not supported/) }
    end
  end

  context 'supported hardware' do
    describe 'MacBookPro10,1' do
      let(:facts) { spec_facts(
        :productname     => 'MacBookPro10,1',
        :dmi             => { 'product' => { 'name' => 'MacBookPro10,1' } },
      ) }

      it { should compile.with_all_deps }
      it { should contain_class('archlinux_macbookretina') }
    end
    describe 'MacBookPro11,4' do
      let(:facts) { spec_facts }

      it { should compile.with_all_deps }
      it { should contain_class('archlinux_macbookretina') }
    end
  end

  context 'unsupported hardware' do
    describe 'To be filled by O.E.M.' do
      let(:facts) { spec_facts(
        :productname     => 'To be filled by O.E.M.',
        :dmi             => { 'product' => { 'name' => 'To be filled by O.E.M.' } },
      ) }
      it { expect { should contain_class('archlinux_macbookretina') }.to raise_error(Puppet::Error, /To be filled by O\.E\.M\. is not a supported hardware productname/) }
    end
  end
  context 'parameters' do
    describe 'default' do
      let(:facts) { spec_facts }

      it { should compile.with_all_deps }
      it { should contain_class('archlinux_macbookretina') }
      it { should contain_class('archlinux_macbookretina::wireless') }
      it { should contain_class('archlinux_macbookretina::videodriver') }
      it { should contain_class('archlinux_macbookretina::mac_keyboard') }
      it { should contain_class('archlinux_macbookretina::ssd') }
      it { should contain_class('archlinux_macbookretina::macfanctld') }
      it { should contain_class('archlinux_macbookretina::touchpad') }
    end
  end
end
