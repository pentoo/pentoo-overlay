# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Intel WiMAX Network Service has no description"
HOMEPAGE="http://linuxwimax.org/"
SRC_URI="http://www.linuxwimax.org/Download?action=AttachFile&do=get&target=WiMAX-Network-Service-${PV}.tar.bz2 -> WiMAX-Network-Service-${PV}.tar.bz2"

inherit linux-info
LICENSE="BSD"
SLOT="0"
EAPI=2
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=">=dev-libs/libnl-1.1"
RDEPEND="${DEPEND}
	net-wireless/intel-wimax-tools
	net-wireless/intel-wimax-binary-supplicant"

S=${WORKDIR}/WiMAX-Network-Service-${PV}

src_configure() {
	econf --with-libwimaxll=/usr/lib/ --with-i2400m="${KV_DIR}" || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README
}

