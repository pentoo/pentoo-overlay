# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="A HTTP packets sniffer"
HOMEPAGE="https://github.com/iamrage/sessionlist"
SRC_URI="https://github.com/iamrage/sessionlist/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="net-libs/libpcap
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/"${PN}"-ldflags.patch
}

src_install() {
	dosbin sessionlist
	dodoc README
}
