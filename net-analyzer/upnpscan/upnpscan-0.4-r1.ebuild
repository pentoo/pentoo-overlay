# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/upnpscan/upnpscan-0.4.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

EAPI=2

WANT_AUTOMAKE="1.9"

inherit autotools

DESCRIPTION="Scans the network for UPNP capable devices"
HOMEPAGE="http://www.cqure.net/wp/upnpscan/"
SRC_URI="http://www.cqure.net/tools/${PN}-v${PV}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static"

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${PN}

src_prepare() {
	sed -i 's|\[:space:\]|[[:space:]]|g' configure || die
}

src_configure() {
	econf $(use_enable static) || die
}

src_install () {
	dobin src/upnpscan || die
}
