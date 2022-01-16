# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="MDK is a proof-of-concept tool to exploit common IEEE 802.11 protocol weaknesses."
HOMEPAGE="https://github.com/aircrack-ng/mdk4"
SRC_URI="https://github.com/aircrack-ng/mdk4/archive/refs/tags/${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}
		dev-libs/libnl"

src_compile(){
	emake || die "Make failed"
}

src_install(){
	dobin ${S}/src/mdk4
	doman ${S}/man/mdk${PV}
}
