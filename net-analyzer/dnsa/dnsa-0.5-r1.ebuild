# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/dnsa/dnsa-0.5_beta.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

EAPI="5"

DESCRIPTION="Swiss-army knife tool for dns auditing"
HOMEPAGE="http://packetfactory.openwall.net/projects/dnsa/index.html"
SRC_URI="http://packetfactory.openwall.net/projects/dnsa/dnsa-current.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug"

DEPEND="net-libs/libnet:1.0
	net-libs/libpcap"

S=${WORKDIR}/${P}/sources

src_configure() {
	myconf="$(use_enable debug)"
	econf $myconf
}

src_install() {
	dosbin dnsa || die "install failed"
	dodoc ../docs/README ../docs/EXAMPLES
}
