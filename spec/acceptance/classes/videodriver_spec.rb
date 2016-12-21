require 'spec_helper_acceptance'

describe 'archlinux_macbookretina::videodriver class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'archlinux_workstation': username => 'myuser', } ->
      class { 'archlinux_workstation::repos::jantman': } ->
      class { 'archlinux_macbookretina::videodriver': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    nouveau_packages = ['xf86-video-nouveau',  'nouveau-dri' ]
    nvidia_packages = [ 'nvidia' ]

    nvidia_packages.each do |pkgname|
      describe package(pkgname) do
        it { should be_installed }
      end
    end

    nouveau_packages.each do |pkgname|
      describe package(pkgname) do
        it { should_not be_installed }
      end
    end
  end
end
