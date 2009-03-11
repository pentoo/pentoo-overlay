# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/dnsa/dnsa-0.5_beta.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

inherit eutils

DESCRIPTION="Swiss-army knife tool for dns auditing"
HOMEPAGE="http://www.packetfactory.net/projects/dnsa/"

MY_P="${PN}-0.5-beta"

SRC_URI="http://www.packetfactory.net/projects/${PN}/${MY_P}.tar.gz"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

DEPEND="<net-libs/libnet-1.1
	>=net-libs/libnet-1.0.2a-r3
	virtual/libpcap"

S=${WORKDIR}/${MY_P}/sources

src_compile() {
	use debug && conf="--enable-debug"
	econf ${conf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin dnsa || die "install failed"
	dodoc ../docs/README ../docs/EXAMPLES
}
