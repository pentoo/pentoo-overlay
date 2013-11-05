# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

MY_PV=${PV/_beta/-beta}

DESCRIPTION="SipBomber is a tool to stress SIP server/proxy implementations."
HOMEPAGE="http://sipp.sourceforge.net/"
#SRC_URI="mirror://sourceforge/$PN/${PN}.${PV}.src.tar.gz"
SRC_URI="https://github.com/SIPp/sipp/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
#https://github.com/SIPp/sipp/archive/3.4-beta2.tar.gz

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pcap sctp ssl"

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/$PN-${MY_PV}

src_configure() {
	econf \
		$(use_with pcap) \
		$(use_with sctp) \
		$(use_with ssl openssl)
}

#src_install () {
#	dobin sipp
#	dodoc README.txt
#}
