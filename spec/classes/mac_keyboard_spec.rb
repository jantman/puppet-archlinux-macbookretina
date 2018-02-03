require 'spec_helper'

describe 'archlinux_macbookretina::mac_keyboard' do
  let(:facts) { spec_facts }

  describe "creates file" do
    it { should compile.with_all_deps }
    it { should contain_class('archlinux_macbookretina::mac_keyboard') }
    it { should contain_file('/etc/modprobe.d/apple.conf')
                 .with({
                         :ensure => 'present',
                         :owner  => 'root',
                         :group  => 'root',
                         :mode   => '0644',
                         :source => 'puppet:///modules/archlinux_macbookretina/apple.conf',
                       })
    }

    it { should contain_file('/etc/systemd/system/kdm.service.d/kbd_backlight.conf')
                 .with({
                         :ensure => 'present',
                         :owner  => 'root',
                         :group  => 'root',
                         :mode   => '0644',
                         :source => 'puppet:///modules/archlinux_macbookretina/kbd_backlight.conf',
                       })
    }

    it { should contain_file('/etc/systemd/system/kdm.service.d')
                 .with({
                         :ensure => 'directory',
                         :owner  => 'root',
                         :group  => 'root',
                         :mode   => '0755',
                       })
                 .that_comes_before('File[/etc/systemd/system/kdm.service.d/kbd_backlight.conf]')
    }
  end
end
