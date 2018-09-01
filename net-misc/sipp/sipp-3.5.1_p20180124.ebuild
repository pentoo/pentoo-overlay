# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="SipBomber is a tool to stress SIP server/proxy implementations."
HOMEPAGE="http://sipp.sourceforge.net/"
SRC_URI="https://github.com/SIPp/sipp/archive/1e12ff0ed4c82cfe5be5a23a4f8af4bd1f477faa.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gsl pcap rtpstream sctp ssl"

DEPEND="sys-libs/ncurses:=[tinfo]
		gsl? ( sci-libs/gsl:= )
		pcap? ( net-libs/libpcap:= )
		sctp? ( net-misc/lksctp-tools:= )
		ssl? ( dev-libs/openssl:= )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-1e12ff0ed4c82cfe5be5a23a4f8af4bd1f477faa"

src_prepare() {
	echo "#define SIPP_VERSION \"v${PV}\"" > include/version.h
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		$(use_with gsl) \
		$(use_with pcap) \
		$(use_with rtpstream) \
		$(use_with sctp) \
		$(use_with ssl openssl)
	sed -i 's/-lcurses/-lcurses -ltinfo/' Makefile
}
