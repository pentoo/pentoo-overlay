# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/libnasl/libnasl-2.2.9-r1.ebuild,v 1.1 2011/04/20 07:52:55 jlec Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="A remote security scanner for Linux (libnasl)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="static-libs"

DEPEND="=net-analyzer/nessus-libraries-${PVR}"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

src_prepare() {
	tc-export CC
	epatch \
		"${FILESDIR}"/${P}-openssl-1.patch \
		"${FILESDIR}"/${P}-gentoo.patch
	sed \
		-e "/^LDFLAGS/s:$:${LDFLAGS}:g" \
		-i nasl.tmpl.in
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--enable-shared
}

src_compile() {
	# emake fails for >= -j2. bug #16471.
	emake -C nasl cflags
	emake
}
