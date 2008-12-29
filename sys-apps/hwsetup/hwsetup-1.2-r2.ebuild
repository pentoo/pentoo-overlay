# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwsetup/hwsetup-1.2-r1.ebuild,v 1.3 2008/10/14 09:30:11 robbat2 Exp $

inherit eutils toolchain-funcs flag-o-matic

MY_PV=${PV}-7
DESCRIPTION="Hardware setup program from Knoppix - used only on LiveCD"
HOMEPAGE="http://www.knopper.net/"
SRC_URI="http://debian-knoppix.alioth.debian.org/sources/${PN}_${MY_PV}.tar.gz"
#http://developer.linuxtag.net/knoppix/sources/${PN}_${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 -mips ppc ppc64 sparc x86"
IUSE="zlib"

COMMON_DEPEND="zlib? ( sys-libs/zlib )
	sys-apps/pciutils"
DEPEND="${COMMON_DEPEND}
	sys-libs/libkudzu"
RDEPEND="${COMMON_DEPEND}
	sys-apps/hwdata-redhat"

pkg_setup() {
	ewarn "This package is designed for use on the LiveCD only and will do "
	ewarn "unspeakably horrible and unexpected things on a normal system."
	ewarn "YOU HAVE BEEN WARNED!!!"
}

src_unpack() {
	unpack ${A}
	epatch \
		"${FILESDIR}"/${MY_PV}-dyn_blacklist.patch \
		"${FILESDIR}"/${PV}-3-fastprobe.patch \
		"${FILESDIR}"/${MY_PV}-gentoo.patch
}

src_compile() {
	append-ldflags -s
	filter-ldflags -Wl,--as-needed --as-needed
	if use zlib ; then
		sed -i \
			-e '/^LIBS=/s,-lpci,-lz -lpci,g' \
			Makefile
	elif built_with_use --missing false sys-apps/pciutils zlib ; then
		die "You need to build with USE=zlib to match sys-apps/pcituils"
	fi
	emake LDFLAGS="${LDFLAGS}" OPT="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	einstall DESTDIR="${D}" PREFIX=/usr MANDIR=/usr/share/man || die "Install failed"
	keepdir /etc/sysconfig
}

pkg_postinst() {
	ewarn "This package is intended for usage on the Gentoo release media.  If"
	ewarn "you are not building a CD, remove this package.  It will not work"
	ewarn "properly on a running system, as Gentoo does not use any of the"
	ewarn "Knoppix-style detection except for CD builds."
}
