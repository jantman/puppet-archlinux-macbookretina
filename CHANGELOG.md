# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

[comment]: # IMPORTANT: Remember to update the links at the bottom of the file!

## [0.3.0] Released 2018-02-03

This release makes major changes to the module code style, testing and deployment. It does not make any functional changes to what the module does or how it works.

- Switch to new-style typed parameters.
- Modernize module layout and testing.
- Update supported and tested Puppet versions to 4 and 5.
- Pin puppetlabs-stdlib dependency to 4.12.0, as this module still uses the deprecated ``validate_`` functions (and its archlinux_workstation dependency requires <= 4.12.0).
- Use puppet-strings for documentation
- Automate deployment through TravisCI
- Minor README and CONTRIBUTING documentation updates.
- Add automated ``github_release`` Rake task.
- Bump puppet-blacksmith gem version and configure for signed tags.
- Reformat changelog
- Add ``.sync.yml`` for my [modulesync_configs](https://github.com/jantman/modulesync_configs)
- Update ``.travis.yml``, ``Gemfile`` and some documentation via modulesync.

## [0.2.2] Released 2017-07-09

- Update for AUR package changes: bcwc-pcie-dkms -> bcwc-pcie-git and bcwc-firmware -> facetimehd-firmware

## [0.2.1] Released 2017-01-08

- updated README with note that bluetooth now works
- many changes to testing (TravisCI, spec, beaker acceptance) and use new versions of dependencies (thanks to petems)
- fix ordering bug in archlinux_macbookretina::touchpad (thanks to petems)

## [0.2.0] Released 2016-10-25

- ensure xf86-input-mtrack-git is absent, in favor of xf86-input-synaptics
- update README.md with updated statuses as of 2016-10-25 and 4.8.4-1 kernel
  - touchpad works, but some 3-finger-tap issues
  - built-in ``brcmfmac`` WiFi driver works for both 2.4GHz and 5GHz
  - backlight adjustment and other hotkeys work with keyboard function keys, using kernel built-in drivers
  - webcam works using AUR reverse-engineered driver
- add ``archlinux_macbookretina::webcam`` for reverse-engineered driver

## [0.1.0] Released 2015-09-16

- complete rewrite to be more reusable, standalone module, and targeted at puppet4

## 0.0.1 Released 2014-03-15

- initial module creation

[0.3.0]: https://github.com/jantman/puppet-archlinux-macbookretina/compare/0.2.2...0.3.0
[0.2.2]: https://github.com/jantman/puppet-archlinux-macbookretina/compare/0.2.1...0.2.2
[0.2.1]: https://github.com/jantman/puppet-archlinux-macbookretina/compare/0.2.0...0.2.1
[0.2.0]: https://github.com/jantman/puppet-archlinux-macbookretina/compare/0.1.0...0.2.0
[0.1.0]: https://github.com/jantman/puppet-archlinux-macbookretina/releases/tag/0.1.0
