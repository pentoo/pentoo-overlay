# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit cmake-utils

DESCRIPTION="a advanced intrusion detection system"
HOMEPAGE="http://www.bro.org/"
SRC_URI="http://www.bro.org/downloads/release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="debug ipv6 perftools"

DEPEND="dev-libs/geoip
		dev-libs/openssl
		sys-apps/file
		net-libs/libpcap
		sys-libs/ncurses
		net-misc/curl
		dev-lang/swig
		perftools? ( dev-util/google-perftools )"
RDEPEND="$DEPEND"

src_configure() {
	# bro uses special configure script for cmake
	# neither cmake-utils_xxx nor econf work correctly.
	./configure \
	--prefix="${EPREFIX}"/usr \
	--scriptdir="${EPREFIX}"/usr/share/bro \
	--conf-files-dir="${EPREFIX}"/etc/bro \
	$(use debug && echo --enable-debug)\
	$(use ipv6  && echo --enable-mobile-ipv6)\
	$(use perftools && echo --enable-perftools)
}

src_compile() {
	cd build && emake -j1
}

src_install() {
	DESTDIR="${D}" emake install || die "install failed"
}
