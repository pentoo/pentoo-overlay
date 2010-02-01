# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-wireless/rtl8180/rtl8180-0.21-r1.ebuild,v 1.1.1.2 2006/03/22 23:00:25 grimmlin Exp $

EAPI="2"

inherit linux-mod eutils

DESCRIPTION="Driver for the rtl8180 wireless chipset with injection patch"
HOMEPAGE="http://rtl8180-sa2400.sourceforge.net"
SRC_URI="mirror://sourceforge/rtl8180-sa2400/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="net-wireless/wireless-tools"

MODULE_NAMES="ieee80211_crypt-r8180(net:) ieee80211_crypt_wep-r8180(net:)
	ieee80211-r8180(net:) r8180(net:)"
CONFIG_CHECK="NET_RADIO CRYPTO CRYPTO_ARC4 CRC32"
BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KSRC=${KV_DIR} MODVERDIR="
}

src_prepare() {
	epatch "${FILESDIR}"/rtl8180_gcc4_fix.patch
	epatch "${FILESDIR}"/rtl8180-0.21.patch
	sed -i -e 's:MODVERDIR=\${PWD}:MODVERDIR=\${PWD}/tmp:'
	sed -i -e 's:MODULE_PARM(\([^,]*\),"i");:module_param(\1, int, 0);:' \
		-e 's:MODULE_PARM(\([^,]*\),"s");:module_param(\1, charp, 0);:' r8180_core.c
}

src_install() {
	linux-mod_src_install

	dodoc AUTHORS CHANGES INSTALL README README.adhoc
}
