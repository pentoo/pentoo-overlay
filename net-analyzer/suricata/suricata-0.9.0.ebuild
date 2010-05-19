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
IUSE="cuda hardened caps"

RDEPEND="dev-libs/libyaml
		dev-libs/libpcre
		net-libs/libpcap
		net-libs/libnet
		cuda? ( dev-util/nvidia-cuda-toolkit )
		sys-libs/libcap-ng"

DEPEND="dev-libs/libyaml
		dev-libs/libpcre
		net-libs/libpcap
		net-libs/libnet
		cuda? ( dev-util/nvidia-cuda-sdk )
		sys-libs/libcap-ng"

src_configure() {
	econf \
		$(use_enable hardened gccprotect) \
		$(use_enable cuda)
}

src_install() {
	DESTDIR="${D}" emake install || die
	dodoc doc/* || die
}
