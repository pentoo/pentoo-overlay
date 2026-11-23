[![pkgcheck](https://github.com/pentoo/pentoo-overlay/actions/workflows/pkgcheck.yaml/badge.svg?event=schedule)](https://github.com/pentoo/pentoo-overlay/actions/workflows/pkgcheck.yaml)
[![Pentoo Metapackage Installable](https://github.com/pentoo/pentoo-overlay/actions/workflows/pentoo-visibility.yaml/badge.svg?event=schedule)](https://github.com/pentoo/pentoo-overlay/actions/workflows/pentoo-visibility.yaml)
[![Mirror Check](https://github.com/pentoo/pentoo-overlay/actions/workflows/mirror-check.yaml/badge.svg?event=schedule)](https://github.com/pentoo/pentoo-overlay/actions/workflows/mirror-check.yaml)

# Pentoo Penetration Testing Overlay
Gentoo overlay for security tools as well as the heart of the Pentoo Livecd

<a href="http://pentoo.ch"><img src="https://github.com/pentoo/pentoo-overlay/wiki/images/pentoo2.png"></a>


<a href="http://pentoo.ch"><img src="https://avatars0.githubusercontent.com/u/6411603?v=3&s=200" align="left" hspace="10" vspace="6"></a>
Pentoo is a Live CD and Live USB designed for penetration testing and security assessment. Based on Gentoo Linux, Pentoo is provided both as 32 and 64 bit installable livecd. Pentoo is also available as an overlay for an existing Gentoo installation. It features packet injection patched wifi drivers, GPGPU cracking software, and lots of tools for penetration testing and security assessment. The Pentoo kernel includes grsecurity and PAX hardening and extra patches - with binaries compiled from a hardened toolchain with the latest nightly versions of some tools available. The latest release of the Pentoo Livecd is the daily autobuilds (https://www.pentoo.ch/isos/daily-autobuilds/)


# Adding the overlay

Update the portage to the latest version

```
emaint sync
```

Make sure that eselect-repository and git are installed

```
emerge eselect-repository git
```

Update list of overlays

```
eselect repository list
```

Add Pentoo overlay

```
eselect repository enable pentoo
```



# Binary package mirrors

| Mirror | amd64_23.0s-hardened |
| :-- | :-: |
| [www.pentoo.ch (primary)](https://www.pentoo.ch/isos/Packages/) | [![pentoo.ch](https://img.shields.io/endpoint?url=https://pentoo.github.io/pentoo-overlay/mirrors/pentoo.ch_amd64_23.0s-hardened.json)](https://github.com/pentoo/pentoo-overlay/actions/workflows/mirror-check.yaml) |
| [pentoo.glpgs.io](https://pentoo.glpgs.io/Packages/) | [![glpgs](https://img.shields.io/endpoint?url=https://pentoo.github.io/pentoo-overlay/mirrors/glpgs_amd64_23.0s-hardened.json)](https://github.com/pentoo/pentoo-overlay/actions/workflows/mirror-check.yaml) |
| [ftp.acc.umu.se](https://ftp.acc.umu.se/mirror/pentoo.ch/Packages/) | [![umu](https://img.shields.io/endpoint?url=https://pentoo.github.io/pentoo-overlay/mirrors/umu_amd64_23.0s-hardened.json)](https://github.com/pentoo/pentoo-overlay/actions/workflows/mirror-check.yaml) |
| [pentoo.osuosl.org](https://pentoo.osuosl.org/Packages/) | [![osuosl](https://img.shields.io/endpoint?url=https://pentoo.github.io/pentoo-overlay/mirrors/osuosl_amd64_23.0s-hardened.json)](https://github.com/pentoo/pentoo-overlay/actions/workflows/mirror-check.yaml) |

Checked every 8 hours. The primary has to be updated within 3 days, and each mirror within a day of the primary.


Want to learn more? [See the wiki.](https://github.com/pentoo/pentoo-overlay/wiki)


Discussion and support information available on https://pentoo.org/
