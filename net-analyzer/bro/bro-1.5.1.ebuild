# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="a advanced intrusion detection system"
HOMEPAGE="http://bro-ids.org/"
# upstream doesn't know what it's packaging oO
SRC_URI="ftp://bro-ids.org/$PN-1.5-release.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug ipv6 perftools"

DEPEND="dev-libs/geoip
		dev-libs/openssl
		sys-apps/file
		net-libs/libpcap
		sys-libs/ncurses
		perftools? ( dev-util/google-perftools )"
RDEPEND="$DEPEND"

src_prepare() {
	# ugly workaround
	sed -i 's|shippedpcap broctl cluster nbdns|shippedpcap broctl cluster nbdns malloc0returnsnull|g' configure
}

src_configure() {
	econf \
		$(use_enable debug)\
		$(use ipv6 && echo --enable-brov6)\
		$(use_enable perftools)
}

src_compile() {
	emake -j1
}

src_install() {
	DESTDIR="${D}" emake install || die "install failed"
}
