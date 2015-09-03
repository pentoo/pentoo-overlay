# Pentoo Penetration Testing Overlay
<a href="http://pentoo.ch"><img src="https://github.com/pentoo/pentoo-overlay/wiki/images/pentoo2.png"></a>
**Gentoo overlay for security tools as well as the heart of the Pentoo Livecd**


<a href="http://pentoo.ch"><img src="https://avatars0.githubusercontent.com/u/6411603?v=3&s=200" align="left" hspace="10" vspace="6"></a>
Pentoo is a Live CD and Live USB designed for penetration testing and security assessment. Based on Gentoo Linux, Pentoo is provided both as 32 and 64 bit installable livecd. Pentoo is also available as an overlay for an existing Gentoo installation. It features packet injection patched wifi drivers, GPGPU cracking software, and lots of tools for penetration testing and security assessment. The Pentoo kernel includes grsecurity and PAX hardening and extra patches - with binaries compiled from a hardened toolchain with the latest nightly versions of some tools available. The latest release of the Pentoo Livecd is [2015 RC3.8](http://www.pentoo.ch/download/)

It's basically a Gentoo, a Linux-based operating system and a meta-distribution, which means that it is built automatically from source code and is customized with the functionality that you want to have and without the unnecessary features that you want to avoid, with lots of customized tools, customized kernel, and much more...

Pentoo comes in many flavors and it is important to choose wisely. Right now, you have two main choices:

Choice 1: hardened or default

You want hardened. No seriously, you want hardened. When was the last time you thought to yourself "I need less security in my pen-testing environment?" In all seriousness, nearly everything works in the hardened builds, and it is vastly more stable than anything you have ever used before with the added bonus of being more secure. You only want default if you are doing exploit against yourself, or you need opengl support. OpenCL and CUDA work fine in the hardened release, but right now, opengl support still eludes us. If you cannot live without opengl acceleration pick default, otherwise, you really want hardened.

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

