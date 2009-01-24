# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostapd/hostapd-0.6.7.ebuild,v 1.1 2009/01/06 19:43:22 gurligebis Exp $

inherit toolchain-funcs linux-info

DESCRIPTION="IEEE 802.11 wireless LAN Host AP daemon"
HOMEPAGE="http://hostap.epitest.fi"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ipv6 logwatch madwifi ssl wps"

DEPEND="ssl? ( dev-libs/openssl )
	>=dev-libs/libnl-1.1
	madwifi? ( ||
		( net-wireless/madwifi-hal-tools
		net-wireless/madwifi-old ) )"
RDEPEND="${RDEPEND}"

S="${S}/hostapd"

generate_config() {
	local CONFIG="${S}/.config"

	# toolchain setup
	echo "CC = $(tc-getCC)" > ${CONFIG}

	# EAP authentication methods
	echo "CONFIG_EAP=y" >> ${CONFIG}
	echo "CONFIG_EAP_MD5=y" >> ${CONFIG}

	if use ssl; then
		# SSL authentication methods
		echo "CONFIG_EAP_TLS=y" >> ${CONFIG}
		echo "CONFIG_EAP_TTLS=y" >> ${CONFIG}
		echo "CONFIG_EAP_MSCHAPV2=y" >> ${CONFIG}
		echo "CONFIG_EAP_PEAP=y" >> ${CONFIG}
	fi

	if use wps; then
		# Enable Wi-Fi Protected Setup
		echo "CONFIG_WPS=y" >> ${CONFIG}
		einfo "Enabling Wi-Fi Protected Setup support"
	fi

	echo "CONFIG_EAP_GTC=y" >> ${CONFIG}
	echo "CONFIG_EAP_SIM=y" >> ${CONFIG}
	echo "CONFIG_EAP_AKA=y" >> ${CONFIG}
	echo "CONFIG_EAP_PAX=y" >> ${CONFIG}
	echo "CONFIG_EAP_PSK=y" >> ${CONFIG}
	echo "CONFIG_EAP_SAKE=y" >> ${CONFIG}
	echo "CONFIG_EAP_GPSK=y" >> ${CONFIG}
	echo "CONFIG_EAP_GPSK_SHA256=y" >> ${CONFIG}

	einfo "Enabling drivers: "

	# drivers
	echo "CONFIG_DRIVER_HOSTAP=y" >> ${CONFIG}
	einfo "  HostAP driver enabled"
	echo "CONFIG_DRIVER_WIRED=y" >> ${CONFIG}
	einfo "  Wired driver enabled"
	echo "CONFIG_DRIVER_PRISM54=y" >> ${CONFIG}
	einfo "  Prism54 driver enabled"

	if use madwifi; then
		# Add include path for madwifi-driver headers
		einfo "  Madwifi driver enabled"
		echo "CFLAGS += -I/usr/include/madwifi" >> ${CONFIG}
		echo "CONFIG_DRIVER_MADWIFI=y" >> ${CONFIG}
	else
		einfo "  Madwifi driver disabled"
	fi

	if [[ ${KV_MAJOR} -ge 2 && ${KV_MINOR} -ge 6 && ${KV_PATCH} -ge 26 ]] ; then
		# Test if header version is new enough (2.6.26+)
		if [ "$(grep NL80211_MNTR_FLAG_COOK_FRAMES /usr/include/linux/nl80211.h)" ]; then
			einfo "  nl80211 driver enabled"
			echo "CONFIG_DRIVER_NL80211=y" >> ${CONFIG}
			echo "CFLAGS += -I/usr/include/netlink" >> ${CONFIG}
			echo "LIBS += -L/usr/lib" >> ${CONFIG}
		else
			einfo "  nl80211 driver disabled (due to header version below 2.6.26)"
		fi
	else
		einfo "  nl80211 driver disabled (due to kernel version below 2.6.26)"
	fi

	# misc
	echo "CONFIG_PKCS12=y" >> ${CONFIG}
	echo "CONFIG_RADIUS_SERVER=y" >> ${CONFIG}
	echo "CONFIG_IAPP=y" >> ${CONFIG}
	echo "CONFIG_IEEE80211R=y" >> ${CONFIG}
	echo "CONFIG_IEEE80211W=y" >> ${CONFIG}
	echo "CONFIG_PEERKEY=y" >> ${CONFIG}
	echo "CONFIG_RSN_PREAUTH=y" >> ${CONFIG}

	if use ipv6; then
		# IPv6 support
		echo "CONFIG_IPV6=y" >> ${CONFIG}
	fi

	# TODO: Add support for BSD drivers
}

src_unpack() {
	unpack ${A}

	cd "${S}"

	sed -i -e "s:/etc/hostapd:/etc/hostapd/hostapd:g" \
		"${S}/hostapd.conf"

	generate_config
}

src_compile() {
	emake || die "emake failed"

	if use ssl; then
		emake nt_password_hash || die "emake nt_password_hash failed"
		emake hlr_auc_gw || die "emake hlr_auc_gw failed"
	fi
}

src_install() {
	insinto /etc/hostapd
	doins hostapd.conf hostapd.accept hostapd.deny \
		hostapd.eap_user hostapd.radius_clients hostapd.sim_db hostapd.wpa_psk

	dosbin hostapd
	dobin hostapd_cli

	use ssl && dobin nt_password_hash
	use ssl && dobin hlr_auc_gw

	newinitd "${FILESDIR}"/${P}-init.d hostapd
	newconfd "${FILESDIR}"/${P}-conf.d hostapd

	doman hostapd.8 hostapd_cli.1

	dodoc ChangeLog developer.txt README
	if use wps; then
		dodoc README-WPS
	fi

	docinto examples
	dodoc wired.conf

	if use logwatch; then
		insinto /etc/log.d/conf/services/
		doins logwatch/hostapd.conf

		exeinto /etc/log.d/scripts/services/
		doexe logwatch/hostapd
	fi
}

pkg_postinst() {
	einfo
	einfo "In order to use ${PN} you need to set up your wireless card"
	einfo "for master mode in /etc/conf.d/net and then start"
	einfo "/etc/init.d/hostapd."
	einfo
	einfo "Example configuration:"
	einfo
	einfo "config_wlan0=( \"192.168.1.1/24\" )"
	einfo "channel_wlan0=\"6\""
	einfo "essid_wlan0=\"test\""
	einfo "mode_wlan0=\"master\""
	einfo
	if use madwifi; then
		einfo "This package compiles against the headers installed by"
		einfo "madwifi-old, madwifi-ng or madwifi-ng-tools."
		einfo "You should remerge ${PN} after upgrading these packages."
		einfo
	fi
	#if [ -e "${KV_DIR}"/net/mac80211 ]; then
	#	einfo "This package now compiles against the headers installed by"
	#	einfo "the kernel source for the mac80211 driver. You should "
	#	einfo "re-emerge ${PN} after upgrading your kernel source."
	#fi

	if use wps; then
		einfo "You have enabled Wi-Fi Protected Setup support, please"
		einfo "read the README-WPS file in /usr/share/doc/${P}"
		einfo "for info on how to use WPS"
	fi
}
