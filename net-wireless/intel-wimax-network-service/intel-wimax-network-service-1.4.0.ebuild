# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit linux-info multilib

MY_P="WiMAX-Network-Service-${PV}"
DESCRIPTION="Intel WiMAX daemon used to interface to the hardware"
HOMEPAGE="http://www.linuxwimax.org/"
SRC_URI="http://www.linuxwimax.org/Download?action=AttachFile&do=get&target=${MY_P}.tar.bz2 -> ${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libnl-1.1"
RDEPEND="${DEPEND}
	net-wireless/intel-wimax-tools
	net-wireless/intel-wimax-binary-supplicant"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf --prefix=/usr --localstatedir=/var --with-libwimaxll=/usr/$(get_libdir) --with-i2400m="${KV_DIR}" || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	doinitd "${FILESDIR}"/wimax || die "failed to place the init daemon"
	dodoc README || die "Failed to find README"
}
