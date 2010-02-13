# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="a advanced intrusion detection system"
HOMEPAGE="http://bro-ids.org/"
# upstream doesn't know what it's packaging oO
SRC_URI="ftp://bro-ids.org/$PN-1.5-release.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	# ugly workaround
	sed -i 's|shippedpcap broctl cluster nbdns|shippedpcap broctl cluster nbdns malloc0returnsnull|g' configure
}

src_install() {
	DESTDIR="${D}" emake install || die "install failed"
}
