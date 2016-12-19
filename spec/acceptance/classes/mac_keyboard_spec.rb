require 'spec_helper_acceptance'

describe 'archlinux_macbookretina::mac_keyboard class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'archlinux_macbookretina::mac_keyboard': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file('/etc/modprobe.d/apple.conf') do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
      its(:content) { should match /options hid_apple fnmode=2/ }
    end

    describe file('/etc/systemd/system/kdm.service.d/kbd_backlight.conf') do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
      its(:content) { should contain('Requires=upower.service') }
      its(:content) { should contain('After=upower.service') }
    end

    describe file('/etc/systemd/system/kdm.service.d') do
      it { should be_directory }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 755 }
    end
  end
end
