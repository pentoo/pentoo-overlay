# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-misc/sipp/sipp-1.1.ebuild,v 1.1.1.1 2006/03/08 18:46:01 grimmlin Exp $

EAPI="2"

inherit eutils
DESCRIPTION="SipBomber is a tool to stress SIP server/proxy implementations."
HOMEPAGE="http://sipp.sourceforge.net/"
SRC_URI="mirror://sourceforge/$PN/${PN}.${PV}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/$PN.svn

src_prepare() {
	epatch "${FILESDIR}"/sipp-3.1-gcc43.patch
}

src_install () {
	dobin sipp
	dodoc README.txt
}
