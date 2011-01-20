# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mkxf86config/mkxf86config-0.9.10.ebuild,v 1.4 2008/09/04 12:53:08 yngwin Exp $

EAPI="2"

inherit eutils

DESCRIPTION="xorg-x11 configuration builder - used only on LiveCD"
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI="http://dev.pentoo.ch/~grimmlin/distfiles/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~mips ppc x86"
IUSE="pentoo"

RDEPEND="!mips? ( sys-apps/hwsetup )"

pkg_setup() {
	ewarn "This package is designed for use on the LiveCD only and will do "
	ewarn "unspeakably horrible and unexpected things on a normal system."
	ewarn "YOU HAVE BEEN WARNED!!!"
}

src_prepare() {
	epatch "${FILESDIR}"/xorg-1.9-kbd.patch
}

src_install() {
	insinto /etc/X11
	if use mips
	then
		doins xorg.conf.impact xorg.conf.newport xorg.conf.o2-fbdev
	else
		doins xorg.conf.in
	fi
	exeinto /usr/sbin
	doexe mkxf86config.sh
	newinitd "${FILESDIR}"/mkxf86config.initd mkxf86config
}
