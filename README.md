[![pkgcheck](https://github.com/pentoo/pentoo-overlay/actions/workflows/pkgcheck.yaml/badge.svg?event=push)](https://github.com/pentoo/pentoo-overlay/actions/workflows/pkgcheck.yaml)
[![Pentoo Metapackage Installable](https://github.com/pentoo/pentoo-overlay/actions/workflows/pentoo-visibility.yaml/badge.svg?event=schedule)](https://github.com/pentoo/pentoo-overlay/actions/workflows/pentoo-visibility.yaml)

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

In case you have been already using layman as a repository manager, make sure to disable it since it has been deprecated by Gentoo:

```
layman -d pentoo
```
and then make sure to inspect and remove /etc/portage/repos.conf/layman.conf and /var/lib/layman.



Want to learn more? [See the wiki.](https://github.com/pentoo/pentoo-overlay/wiki)


Discussion and support available on irc.freenode.net  **#pentoo**

