# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Extracts files from network packet captures"
HOMEPAGE="http://tcpxtract.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
}
