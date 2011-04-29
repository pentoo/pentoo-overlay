# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux (openvas-administrator)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/853/${P}.tar.gz"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="app-crypt/gpgme
	>=dev-libs/glib-2
	net-libs/gnutls
	net-libs/libpcap
	net-analyzer/openvas-libraries:4"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

CMAKE_BUILD_DIR="${S}"

src_configure() {
	mycmakeargs=(-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc)
	cmake-utils_src_configure || die
}

src_compile() {
	mycmakeargs=(-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc)
	cmake-utils_src_compile || die
}

src_install() {
	cmake-utils_src_install || die
	doinitd "${FILESDIR}"/openvasad || die
}
