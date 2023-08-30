# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info flag-o-matic

DESCRIPTION="VoIP Hopper is a tool that rapidly runs a VLAN Hop into the Voice VLAN"
HOMEPAGE="http://voiphopper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="net-libs/libpcap
	net-libs/libtirpc"
RDEPEND="${DEPEND}"

pkg_setup() {
	CONFIG_CHECK="~VLAN_8021Q"
	linux-info_pkg_setup
}

src_prepare() {
	sed -i "s%<linux/if_ether.h>%<netinet/if_ether.h>%" src/dhcpclient.h || die
	sed -i "s%<linux/if_tr.h>%<netinet/if_tr.h>%" src/dhcpclient.h || die
	eapply_user
}

src_configure() {
	append-cflags -fcommon #dead upstream and I don't care
	econf
	sed -i 's#-I.#-I. -I/usr/include/tirpc#' src/Makefile || die
}

src_install() {
	dobin src/voiphopper
	dodoc README USAGE
}
