require 'spec_helper'

describe 'archlinux_macbookretina::videodriver' do
  let(:facts) {{
    :osfamily        => 'Archlinux',
    :operatingsystem => 'Archlinux',
    :productname     => 'MacBookPro11,4',
  }}

  context 'invalid driver param' do
    let(:params) {{ :driver => 'foo' }}

    describe "raises error" do
      it { expect { should contain_class('archlinux_macbookretina::videodriver') }.to raise_error(Puppet::Error, /"foo" does not match/) }
      end
  end
  context 'default params' do
    let(:params) {{ }}
    describe "installs packages" do
      it { should compile.with_all_deps }
      it { should contain_class('archlinux_macbookretina::videodriver') }

      nouveau_packages = ['xf86-video-nouveau',  'nouveau-dri' ]
      nvidia_packages = [ 'nvidia' ]

      nvidia_packages.each do |pkgname|
        it { should contain_package(pkgname)
                     .with_ensure('present')
        }
      end
      nouveau_packages.each do |pkgname|
        it { should contain_package(pkgname)
                     .with_ensure('absent')
                     .with_install_options('-dds')
                     .that_comes_before('Package[nvidia]')
        }
      end
    end
  end
  context 'driver param set to nouveau' do
    let(:params) {{ :driver => 'nouveau' }}
    describe "installs packages" do
      it { should compile.with_all_deps }
      it { should contain_class('archlinux_macbookretina::videodriver') }

      nouveau_packages = ['xf86-video-nouveau',  'nouveau-dri' ]
      nvidia_packages = [ 'nvidia' ]

      nouveau_packages.each do |pkgname|
        it { should contain_package(pkgname)
                     .with_ensure('present')
        }
      end
      nvidia_packages.each do |pkgname|
        it { should contain_package(pkgname)
                     .with_ensure('absent')
                     .with_install_options('-dds')
                     .that_comes_before('Package[xf86-video-nouveau]')
        }
      end
    end
  end
end
