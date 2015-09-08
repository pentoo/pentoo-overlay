# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostapd/hostapd-2.0.ebuild,v 1.3 2013/04/29 18:35:53 scarabeus Exp $

EAPI="4"

inherit toolchain-funcs eutils

DESCRIPTION="IEEE 802.11 wireless LAN Host AP daemon"
HOMEPAGE="http://hostap.epitest.fi"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="amd64 ~mips ppc x86"
IUSE="debug ipv6 +karma karma_cli logwatch madwifi +ssl +wpe +wps +crda"

DEPEND="ssl? ( dev-libs/openssl )
	kernel_linux? (
		dev-libs/libnl:3
		crda? ( net-wireless/crda )
	)
	madwifi? ( ||
		( >net-wireless/madwifi-ng-tools-0.9.3
		net-wireless/madwifi-old ) )"
RDEPEND="${DEPEND}"

S="${S}/${PN}"

src_prepare() {
	cd ..
	epatch "${FILESDIR}/${P}-tls_length_fix.patch"
#there is initial cui support in that version. Do we still need it?
#	use cui && epatch "${FILESDIR}/${P}-cui.patch"
	use karma && epatch "${FILESDIR}/${P}-karma.patch"
	use karma_cli && epatch "${FILESDIR}/${P}-karma_cli.patch"
	use wpe && use karma && epatch "${FILESDIR}/${P}-wpe_karma.patch"
	use wpe && use karma_cli && epatch "${FILESDIR}/${P}-wpe_karma_cli.patch"

	sed -i -e "s:/etc/hostapd:/etc/hostapd/hostapd:g" \
		"${S}/hostapd.conf" || die
}

src_configure() {
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
		echo "CONFIG_WPS2=y" >> ${CONFIG}
		echo "CONFIG_WPS_UPNP=y" >> ${CONFIG}
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
	echo "CONFIG_DRIVER_NONE=y" >> ${CONFIG}
	einfo "  None driver enabled"

	if use madwifi; then
		# Add include path for madwifi-driver headers
		einfo "  Madwifi driver enabled"
		echo "CFLAGS += -I/usr/include/madwifi" >> ${CONFIG}
		echo "CONFIG_DRIVER_MADWIFI=y" >> ${CONFIG}
	else
		einfo "  Madwifi driver disabled"
	fi

	einfo "  nl80211 driver enabled"
	echo "CONFIG_DRIVER_NL80211=y" >> ${CONFIG}
	echo "CFLAGS += -I/usr/include/netlink" >> ${CONFIG}
	echo "LIBS += -L/usr/lib" >> ${CONFIG}

	# misc
	echo "CONFIG_PKCS12=y" >> ${CONFIG}
	echo "CONFIG_RADIUS_SERVER=y" >> ${CONFIG}
	echo "CONFIG_IAPP=y" >> ${CONFIG}
	echo "CONFIG_IEEE80211R=y" >> ${CONFIG}
	echo "CONFIG_IEEE80211W=y" >> ${CONFIG}
	echo "CONFIG_IEEE80211N=y" >> ${CONFIG}
	echo "CONFIG_PEERKEY=y" >> ${CONFIG}
	echo "CONFIG_RSN_PREAUTH=y" >> ${CONFIG}
	echo "CONFIG_INTERWORKING=y" >> ${CONFIG}

	if use ipv6; then
		# IPv6 support
		echo "CONFIG_IPV6=y" >> ${CONFIG}
	fi

	if ! use debug; then
		echo "CONFIG_NO_STDOUT_DEBUG=y" >> ${CONFIG}
	fi

	# If we are using libnl 2.0 and above, enable support for it
	# Removed for now, since the 3.2 version is broken, and we don't
	# support it.
	if has_version ">=dev-libs/libnl-3.2"; then
		echo "CONFIG_LIBNL32=y" >> .config
	fi

	# TODO: Add support for BSD drivers

	default_src_configure
}

src_compile() {
	emake V=1

	if use ssl; then
		emake V=1 nt_password_hash
		emake V=1 hlr_auc_gw
	fi
}

src_install() {
	insinto /etc/${PN}
	doins ${PN}.{conf,accept,deny,eap_user,radius_clients,sim_db,wpa_psk}
	doins ${FILESDIR}/hostapd-int.conf ${FILESDIR}/hostapd-ext.conf

	fperms -R 600 /etc/${PN}

	dosbin ${PN}
	dobin ${PN}_cli

	use ssl && dobin nt_password_hash hlr_auc_gw

	newinitd "${FILESDIR}"/${PN}-init.d ${PN}
	newconfd "${FILESDIR}"/${PN}-conf.d ${PN}

	doman ${PN}{.8,_cli.1}

	dodoc ChangeLog README
	use wps && dodoc README-WPS

	docinto examples
	dodoc wired.conf

	if use logwatch; then
		insinto /etc/log.d/conf/services/
		doins logwatch/${PN}.conf

		exeinto /etc/log.d/scripts/services/
		doexe logwatch/${PN}
	fi
}

pkg_postinst() {
	einfo
	einfo "In order to use ${PN} you need to set up your wireless card"
	einfo "for master mode in /etc/conf.d/net and then start"
	einfo "/etc/init.d/${PN}."
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
		einfo "Since you are using the madwifi-ng driver, you should disable or"
		einfo "comment out wme_enabled from ${PN}.conf, since it will"
		einfo "cause problems otherwise (see bug #260377"
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
