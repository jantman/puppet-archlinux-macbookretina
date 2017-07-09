require 'spec_helper_acceptance'

describe 'archlinux_macbookretina::webcam class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'archlinux_macbookretina::webcam': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('bcwc-pcie-git') do
      it { should be_installed }
    end

    describe package('bcwc-pcie-firmware') do
      it { should be_installed }
    end
  end
end
