2017-07-09 release 0.2.2
- Update for AUR package changes: bcwc-pcie-dkms -> bcwc-pcie-git and bcwc-firmware -> facetimehd-firmware

2017-01-08 release 0.2.1
- updated README with note that bluetooth now works
- many changes to testing (TravisCI, spec, beaker acceptance) and use new versions of dependencies (thanks to petems)
- fix ordering bug in archlinux_macbookretina::touchpad (thanks to petems)

2016-10-25 release 0.2.0
- ensure xf86-input-mtrack-git is absent, in favor of xf86-input-synaptics
- update README.md with updated statuses as of 2016-10-25 and 4.8.4-1 kernel
  - touchpad works, but some 3-finger-tap issues
  - built-in ``brcmfmac`` WiFi driver works for both 2.4GHz and 5GHz
  - backlight adjustment and other hotkeys work with keyboard function keys, using kernel built-in drivers
  - webcam works using AUR reverse-engineered driver
- add ``archlinux_macbookretina::webcam`` for reverse-engineered driver

2015-09-16 Release 0.1.0
- complete rewrite to be more reusable, standalone module, and targeted at puppet4

2014-03-15 Release 0.0.1
- initial module creation
