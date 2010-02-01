# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-mod

# The following works with both pre-releases and releases
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

IEEE80211_VERSION="1.2.15"
FW_VERSION="3.0"

DESCRIPTION="Driver for the Intel 2200BG/2915ABG miniPCI/PCI adapters patched with modified inject patches"
HOMEPAGE="http://ipw2200.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug inject"
DEPEND=">=net-wireless/ieee80211-${IEEE80211_VERSION}
		sys-apps/sed"
RDEPEND=">=net-wireless/ieee80211-${IEEE80211_VERSION}
		>=net-wireless/ipw2200-firmware-${FW_VERSION}
		net-wireless/wireless-tools"

BUILD_TARGETS="all"
MODULE_NAMES="ipw2200(net/wireless:)"
MODULESD_IPW2200_DOCS="README.ipw2200"

CONFIG_CHECK="NET_RADIO FW_LOADER !IPW2200"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
ERROR_FW_LOADER="${P} requires Hotplug firmware loading support (CONFIG_FW_LOADER)."
ERROR_IPW2200="${P} requires the in-kernel version of the IPW2200 driver to be disabled (CONFIG_IPW2200)"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi

	if [[ ! -f ${ROOT}/lib/modules/${KV_FULL}/net/ieee80211/ieee80211.${KV_OBJ} ]]; then
		eerror
		eerror "Looks like you forgot to remerge net-wireless/ieee80211 after"
		eerror "upgrading your kernel."
		eerror
		eerror "Hint: use sys-kernel/module-rebuild for keeping track of which"
		eerror "modules needs to be remerged after a kernel upgrade."
		eerror
		die "${ROOT}/lib/modules/${KV_FULL}/net/ieee80211/ieee80211.${KV_OBJ} not found"
	fi

	BUILD_PARAMS="KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR} IEEE80211_INC=/usr/include"
}

src_unpack() {
	local debug="n" radiotap="n"

	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-modverdir.patch"
	if use inject; then
		epatch "${FILESDIR}/${P}-inject.patch"
	fi

	use debug && debug="y"
	sed -i -e "s:^\(CONFIG_IPW2200_DEBUG\)=.*:\1=${debug}:" "${S}"/Makefile
}

src_compile() {
	linux-mod_src_compile

	einfo
	einfo "You may safely ignore any warnings from above compilation about"
	einfo "undefined references to the ieee80211 subsystem."
	einfo
}

src_install() {
	linux-mod_src_install

	dodoc CHANGES ISSUES
}
