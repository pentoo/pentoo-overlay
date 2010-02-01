# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-wireless/prism54/prism54-20050724.ebuild,v 1.1.1.1 2006/03/22 23:30:35 grimmlin Exp $

EAPI="2"

inherit linux-mod

MY_P=${P/prism54-/prism54-svn-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Driver for Intersil Prism GT / Prism Duette wireless chipsets with injection patch"
HOMEPAGE="http://prism54.org/"
SRC_URI="http://www.pentoo.ch/distfiles/${MY_P}.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="pcmcia"
RDEPEND="net-wireless/prism54-firmware
	 net-wireless/wireless-tools"

MODULE_NAMES="prism54(net:${S}/ksrc)"
BUILD_PARAMS="KVER=${KV_FULL} KDIR=${KV_DIR}"
BUILD_TARGETS="modules"

CONFIG_CHECK="!PRISM54 NET_RADIO FW_LOADER"
PRISM54_ERROR="You need prism54-firmware for the in-kernel driver or deselect
the in-kernel driver to use the (probably older) driver from this ebuild."
NET_RADIO_ERROR='You should enable "Wireless LAN drivers (non-hamradio) &
Wireless Extensions"[CONFIG_NET_RADIO] in your kernel config'
FW_LOADER_ERROR="Make sure you have CONFIG_FW_LOADER enabled in your kernel."

use pcmcia && CONFIG_CHECK="${CONFIG_CHECK} PCMCIA CARDBUS"
PCMCIA_ERROR=CARDBUS_ERROR="General setup  --->
	PCMCIA/CardBus support  --->
		PCMCIA/CardBus support (m or y)
		[*]   CardBus support (Important!)"

pkg_setup() {
	linux-mod_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/prism54-svn-20050724.patch
}

src_install() {
	linux-mod_src_install
	dodoc README ksrc/ChangeLog
}
