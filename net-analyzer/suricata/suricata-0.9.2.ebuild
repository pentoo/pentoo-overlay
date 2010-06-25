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
IUSE="hardened caps +netfilter"

RDEPEND="dev-libs/libyaml
		dev-libs/libpcre
		net-libs/libpcap
		net-libs/libnet
		sys-libs/libcap-ng"

DEPEND="dev-libs/libyaml
		dev-libs/libpcre
		net-libs/libpcap
		net-libs/libnet
		sys-libs/libcap-ng
		netfilter? ( net-libs/libnetfilter_queue
		net-libs/libnfnetlink )"

src_configure() {
	econf \
		$(use_enable hardened gccprotect) \
		$(use_enable iptables nfqueue)
}

src_install() {
	DESTDIR="${D}" emake install || die
	dodoc doc/* || die
}
