# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="SipBomber is a tool to stress SIP server/proxy implementations."
HOMEPAGE="http://sipp.sourceforge.net/"
SRC_URI="https://github.com/SIPp/sipp/releases/download/v${PV}/sipp-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gsl pcap rtpstream sctp ssl"

DEPEND="dev-libs/openssl:0=
		sys-libs/ncurses:="
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_with gsl) \
		$(use_with pcap) \
		$(use_with rtpstream) \
		$(use_with sctp) \
		$(use_with ssl openssl)
}
