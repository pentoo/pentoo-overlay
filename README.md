# Pentoo Penetration Testing Overlay
Gentoo overlay for security tools as well as the heart of the Pentoo Livecd

<a href="http://pentoo.ch"><img src="https://github.com/pentoo/pentoo-overlay/wiki/images/pentoo2.png"></a>


<a href="http://pentoo.ch"><img src="https://avatars0.githubusercontent.com/u/6411603?v=3&s=200" align="left" hspace="10" vspace="6"></a>
Pentoo is a Live CD and Live USB designed for penetration testing and security assessment. Based on Gentoo Linux, Pentoo is provided both as 32 and 64 bit installable livecd. Pentoo is also available as an overlay for an existing Gentoo installation. It features packet injection patched wifi drivers, GPGPU cracking software, and lots of tools for penetration testing and security assessment. The Pentoo kernel includes grsecurity and PAX hardening and extra patches - with binaries compiled from a hardened toolchain with the latest nightly versions of some tools available. The latest release of the Pentoo Livecd is [2015 RC3.8](http://www.pentoo.ch/download/)


# Adding the overlay

Update the portage to the latest version

```
emerge --sync
```

Make sure that layman and git are installed

```
emerge app-portage/layman git
```

Update list of overlays

```
layman -L
```

Add Pentoo overlay

```
layman -a pentoo
```


Want to learn more? [See the wiki.](https://github.com/pentoo/pentoo-overlay/wiki)


Discussion and support available on irc.freenode.net  **#pentoo**

