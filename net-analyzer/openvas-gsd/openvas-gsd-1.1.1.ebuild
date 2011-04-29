# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux GSD"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/860/gsd-${PV}.tar.gz"
SLOT="3"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2
	net-libs/gnutls
	net-analyzer/openvas-libraries:4
	x11-libs/qt-core:4"
DEPEND="${RDEPEND}
	dev-util/cmake
	doc? ( app-doc/doxygen )"
S="$WORKDIR/gsd-${PV}"

CMAKE_BUILD_DIR="${S}"

src_prepare() {
	if ! use doc ; then
		sed -i 's/FATAL_ERROR/WARNING/' doc/CMakeLists.txt || die
	fi
}

src_configure() {
	mycmakeargs=(-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc)
	cmake-utils_src_configure || die
}

src_compile() {
	mycmakeargs=(-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc)
	cmake-utils_src_compile || die
}
