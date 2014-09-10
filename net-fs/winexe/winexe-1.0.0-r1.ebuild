# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

DESCRIPTION="remotely execute commands on Windows NT/2000/XP/2003 systems, with lmhash passthrough support"
HOMEPAGE="http://sourceforge.net/projects/winexe/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}-1.00.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND="net-libs/gnutls
	dev-libs/popt
	dev-libs/cyrus-sasl
	sys-libs/tdb
	sys-libs/zlib
	sys-libs/talloc
	dev-libs/libgcrypt:="
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-1.00

src_prepare() {
	epatch "${FILESDIR}"/winexe-passthrough.patch
	epatch "${FILESDIR}"/winexe-getoptstd.patch
	epatch "${FILESDIR}"/winexe-gnutlslowat.patch
}

src_configure() {
	cd source4
	./autogen.sh # should we be using eautoreconf really?
	econf \
		--enable-fhs
}
src_compile() {
	cd source4
	emake || die "compile failed"
}
src_install() {
	dobin "${S}"/source4/bin/winexe
}
