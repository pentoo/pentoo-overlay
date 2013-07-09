# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/dnsa/dnsa-0.5_beta.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

EAPI="2"

MY_P="${PN}-0.5-beta"
DESCRIPTION="Swiss-army knife tool for dns auditing"
HOMEPAGE="http://packetfactory.openwall.net/projects/dnsa/index.html"
SRC_URI="http://packetfactory.openwall.net/projects/dnsa/dnsa-current.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="<net-libs/libnet-1.1
	>=net-libs/libnet-1.0.2a-r3
	net-libs/libpcap"

S=${WORKDIR}/${MY_P}/sources

src_configure() {
	myconf="$(use_enable debug)"
	econf $myconf || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin dnsa || die "install failed"
	dodoc ../docs/README ../docs/EXAMPLES
}
