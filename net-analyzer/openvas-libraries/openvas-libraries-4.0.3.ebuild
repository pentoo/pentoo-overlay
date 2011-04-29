# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils eutils

DESCRIPTION="A remote security scanner for Linux"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/859/${P}.tar.gz"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="doc restricted"

RDEPEND=">=app-crypt/gpgme-1.1.2
	>=dev-libs/glib-2.12
	dev-libs/libgcrypt
	>=net-libs/gnutls-2.0
	net-libs/libpcap
	!net-analyzer/openvas-libnasl
	sys-apps/util-linux" #for libuuid
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	doc? ( app-doc/doxygen )"

#nasl_grammar.y is generated in source but cmake build in ${S}_build
CMAKE_BUILD_DIR="${S}"
pkg_setup() {
	if use restricted ; then
		einfo "Creating openvas user"
		enewgroup openvas || die
		enewuser openvas -1 -1 /var/lib/openvas/ openvas || die
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}_cmake.patch
	sed -i 's/\/run/\/run\/openvas\//g' CMakeLists.txt || die
}

src_configure() {
# localstatedir redefined to /var because openvas install all stuff in $localstatedir/lib/openvas
# letting localstatedir to /var/lib goes to stuff installed in /var/lib/lib/openvas
# openvas-librries-4 does the same but in /usr/var
	mycmakeargs=(-DLOCALSTATEDIR=/var \
	-DSYSCONFDIR=/etc \
	-DOPENVAS_PID_DIR=/var/run/openvas/)
	cmake-utils_src_configure || die
	#TODO doesnt respect CFLAGS
}

src_compile() {
	mycmakeargs=(-DLOCALSTATEDIR=/var \
	-DSYSCONFDIR=/etc \
	-DOPENVAS_PID_DIR=/var/run/openvas/)
	cmake-utils_src_compile  || die
	if use doc ; then
		emake doc || die
	fi
}

src_install() {
	cmake-utils_src_install || die
	if use doc ; then
		dodoc "${S}"/doc/generated/html/* || die
		dodoc "${S}"/doc/generated/latex/* || die
	fi
	dodir /var/run/openvas/ || die
	dodir /var/cache/openvas/ || die
	if use restricted ; then
		fowners openvas:openvas /var/run/openvas/ || die
		fowners openvas:openvas /var/cache/openvas || die
		fowners openvas:openvas /var/lib/openvas/ || die
		fowners openvas:openvas /var/log/openvas/ || die
		fowners openvas:openvas /var/cache/openvas/ || die
		fowners root:openvas /etc/openvas/ || die
	fi
}
