# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="next generation intrusion detection and prevention engine"
HOMEPAGE="http://www.openinfosecfoundation.org"
SRC_URI="http://www.openinfosecfoundation.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="hardened +netfilter cuda debug +prelude caps"

RDEPEND="dev-libs/libyaml
		dev-libs/libpcre
		net-libs/libpcap
		net-libs/libnet
		caps? ( sys-libs/libcap-ng )
		netfilter? ( net-libs/libnetfilter_queue
		net-libs/libnfnetlink )
		cuda? ( dev-util/nvidia-cuda-toolkit )
		prelude? ( dev-libs/libprelude )"

DEPEND="dev-libs/libyaml
		dev-libs/libpcre
		net-libs/libpcap
		net-libs/libnet
		caps? ( sys-libs/libcap-ng )
		netfilter? ( net-libs/libnetfilter_queue
		net-libs/libnfnetlink )
		cuda? ( dev-util/nvidia-cuda-sdk
		dev-util/nvidia-cuda-toolkit )
		prelude? ( dev-libs/libprelude )"

src_configure() {
	econf \
		$(use_enable hardened gccprotect) \
		$(use_enable netfilter nfqueue) \
		$(use_enable cuda) \
		$(use_enable debug) \
		$(use_enable prelude) || die
}

src_install() {
	DESTDIR="${D}" emake install || die
	dodoc doc/* || die
}
