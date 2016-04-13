# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit autotools

DESCRIPTION="SipBomber is a tool to stress SIP server/proxy implementations."
HOMEPAGE="http://sipp.sourceforge.net/"
SRC_URI="https://github.com/SIPp/sipp/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gsl pcap rtpstream sctp ssl"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	echo "#define SIPP_VERSION \"v3.5.1\"" > include/version.h
	eautoreconf
}

src_configure() {
	econf \
		$(use_with gsl) \
		$(use_with pcap) \
		$(use_with rtpstream) \
		$(use_with sctp) \
		$(use_with ssl openssl)
}
