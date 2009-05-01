# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wpa_supplicant/wpa_supplicant-0.6.9.ebuild,v 1.1 2009/04/15 21:45:22 gurligebis Exp $

EAPI="2"

inherit eutils toolchain-funcs qt3 qt4

DESCRIPTION="IEEE 802.1X/WPA supplicant for secure wireless transfers"
HOMEPAGE="http://hostap.epitest.fi/wpa_supplicant/"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz"
LICENSE="|| ( GPL-2 BSD )"

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="dbus debug gnutls gsm madwifi ps3 qt3 qt4 readline ssl wps kernel_linux kernel_FreeBSD"

DEPEND="dev-libs/libnl
	dbus? ( sys-apps/dbus )
	kernel_linux? (
		gsm? ( sys-apps/pcsc-lite )
		madwifi? ( ||
			( >net-wireless/madwifi-ng-tools-0.9.3
			net-wireless/madwifi-old
			madwifi-hal-tools )
		)
	)
	!kernel_linux? ( net-libs/libpcap )
	qt4? ( x11-libs/qt-gui:4 )
	!qt4? ( qt3? ( x11-libs/qt:3 ) )
	readline? ( sys-libs/ncurses sys-libs/readline )
	gnutls? ( net-libs/gnutls )
	!gnutls? ( ssl? ( dev-libs/openssl ) )
	!gnutls? ( !ssl? ( dev-libs/libtommath ) )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/${PN}"

pkg_setup() {
	if use gnutls && use ssl ; then
		einfo "You have both 'gnutls' and 'ssl' USE flags enabled: defaulting to USE=\"ssl\""
	fi

	if use qt3 && use qt4 ; then
		einfo "You have both 'qt3' and 'qt4' USE flags enabled: defaulting to USE=\"qt4\""
	fi
}

src_prepare() {
	# net/bpf.h needed for net-libs/libpcap on Gentoo/FreeBSD
	sed -i \
		-e "s:\(#include <pcap\.h>\):#include <net/bpf.h>\n\1:" \
		../src/l2_packet/l2_packet_freebsd.c || die

	# People seem to take the example configuration file too literally (bug #102361)
	sed -i \
		-e "s:^\(opensc_engine_path\):#\1:" \
		-e "s:^\(pkcs11_engine_path\):#\1:" \
		-e "s:^\(pkcs11_module_path\):#\1:" \
		wpa_supplicant.conf || die

	# Change configuration to match Gentoo locations (bug #143750)
	sed -i \
		-e "s:/usr/lib/opensc:/usr/$(get_libdir):" \
		-e "s:/usr/lib/pkcs11:/usr/$(get_libdir):" \
		wpa_supplicant.conf || die

	epatch "${FILESDIR}"/dbus_path_fix.patch
}

src_configure() {
	# Toolchain setup
	echo "CC = $(tc-getCC)" > .config

	# Basic setup
	echo "CONFIG_CTRL_IFACE=y" >> .config
	echo "CONFIG_BACKEND=file" >> .config

	# Basic authentication methods
	# NOTE: we don't set GPSK or SAKE as they conflict
	# with the below options
	echo "CONFIG_EAP_GTC=y"         >> .config
	echo "CONFIG_EAP_MD5=y"         >> .config
	echo "CONFIG_EAP_OTP=y"         >> .config
	echo "CONFIG_EAP_PAX=y"         >> .config
	echo "CONFIG_EAP_PSK=y"         >> .config
	echo "CONFIG_EAP_TLV=y"         >> .config
	echo "CONFIG_IEEE8021X_EAPOL=y" >> .config
	echo "CONFIG_PKCS12=y"          >> .config
	echo "CONFIG_PEERKEY=y"         >> .config
	echo "CONFIG_EAP_LEAP=y"        >> .config
	echo "CONFIG_EAP_MSCHAPV2=y"    >> .config
	echo "CONFIG_EAP_PEAP=y"        >> .config
	echo "CONFIG_EAP_TLS=y"         >> .config
	echo "CONFIG_EAP_TTLS=y"        >> .config

	if use dbus ; then
		echo "CONFIG_CTRL_IFACE_DBUS=y" >> .config
	fi

	if use debug ; then
		echo "CONFIG_DEBUG_FILE=y" >> .config
	fi

	if use gsm ; then
		# Smart card authentication
		echo "CONFIG_EAP_SIM=y"       >> .config
		echo "CONFIG_EAP_AKA=y"       >> .config
		echo "CONFIG_EAP_AKA_PRIME=y" >> .config
		echo "CONFIG_PCSC=y"          >> .config
	fi

	if use readline ; then
		# readline/history support for wpa_cli
		echo "CONFIG_READLINE=y" >> .config
	fi

	# SSL authentication methods
	if use ssl ; then
		echo "CONFIG_TLS=openssl"    >> .config
		echo "CONFIG_SMARTCARD=y"    >> .config
	elif use gnutls ; then
		echo "CONFIG_TLS=gnutls"     >> .config
		echo "CONFIG_GNUTLS_EXTRA=y" >> .config
	else
		echo "CONFIG_TLS=internal"   >> .config
	fi

	if use kernel_linux ; then
		# Linux specific drivers
		echo "CONFIG_DRIVER_ATMEL=y"       >> .config
		#echo "CONFIG_DRIVER_BROADCOM=y"   >> .config
		#echo "CONFIG_DRIVER_HERMES=y"	   >> .config
		echo "CONFIG_DRIVER_HOSTAP=y"      >> .config
		echo "CONFIG_DRIVER_IPW=y"         >> .config
		echo "CONFIG_DRIVER_NDISWRAPPER=y" >> .config
		echo "CONFIG_DRIVER_NL80211=y"     >> .config
		#echo "CONFIG_DRIVER_PRISM54=y"    >> .config
		echo "CONFIG_DRIVER_RALINK=y"      >> .config
		echo "CONFIG_DRIVER_WEXT=y"        >> .config
		echo "CONFIG_DRIVER_WIRED=y"       >> .config

		if use madwifi ; then
			# Add include path for madwifi-driver headers
			echo "CFLAGS += -I/usr/include/madwifi" >> .config
			echo "CONFIG_DRIVER_MADWIFI=y"          >> .config
		fi

		if use ps3 ; then
			echo "CONFIG_DRIVER_PS3=y" >> .config
		fi

	elif use kernel_FreeBSD ; then
		# FreeBSD specific driver
		echo "CONFIG_DRIVER_BSD=y" >> .config
	fi

	# Wi-Fi Protected Setup (WPS)
	if use wps ; then
		echo "CONFIG_WPS=y" >> .config
	fi

	# Enable mitigation against certain attacks against TKIP
	echo "CONFIG_DELAYED_MIC_ERROR_REPORT=y" >> .config
}

src_compile() {
	emake || die "emake failed"

	if use qt4 ; then
		cd "${S}"/wpa_gui-qt4
		eqmake4 wpa_gui.pro
		emake || die "Qt4 wpa_gui compilation failed"
	elif use qt3 ; then
		cd "${S}"/wpa_gui
		eqmake3 wpa_gui.pro
		emake || die "Qt3 wpa_gui compilation failed"
	fi
}

src_install() {
	dosbin wpa_supplicant || die
	dobin wpa_cli wpa_passphrase || die

	# baselayout-1 compat
	dosym /usr/sbin/wpa_supplicant /sbin/wpa_supplicant || die
	dosym /usr/bin/wpa_cli /bin/wpa_cli || die

	exeinto /etc/wpa_supplicant/
	newexe "${FILESDIR}"/wpa_cli.sh wpa_cli.sh

	dodoc ChangeLog {eap_testing,todo}.txt README{,-WPS} \
		wpa_supplicant.conf || die "dodoc failed"

	doman doc/docbook/*.{5,8} || die "doman failed"

	if use qt4 ; then
		into /usr
		dobin wpa_gui-qt4/wpa_gui || die
	elif use qt3 ; then
		into /usr
		dobin wpa_gui/wpa_gui || die
	fi

	if use qt3 || use qt4 ; then
		make_desktop_entry wpa_gui "WPA Supplicant Administration GUI" "wpa_gui" "Qt;Network;"
	fi

	if use dbus ; then
		insinto /etc/dbus-1/system.d
		newins dbus-wpa_supplicant.conf wpa_supplicant.conf || die
		insinto /usr/share/dbus-1/system-services
		newins dbus-wpa_supplicant.service 'fi.epitest.hostap.WPASupplicant.service' || die
		keepdir /var/run/wpa_supplicant
	fi
}

pkg_postinst() {
	einfo "If this is a clean installation of wpa_supplicant, you"
	einfo "have to create a configuration file named"
	einfo "/etc/wpa_supplicant/wpa_supplicant.conf"
	einfo
	einfo "An example configuration file is available for reference in"
	einfo "/usr/share/doc/${PF}/"

	if [[ -e ${ROOT}etc/wpa_supplicant.conf ]] ; then
		echo
		ewarn "WARNING: your old configuration file ${ROOT}etc/wpa_supplicant.conf"
		ewarn "needs to be moved to ${ROOT}etc/wpa_supplicant/wpa_supplicant.conf"
	fi

	if use madwifi ; then
		echo
		einfo "This package compiles against the headers installed by"
		einfo "madwifi-old, madwifi-ng or madwifi-ng-tools."
		einfo "You should re-emerge ${PN} after upgrading these packages."
	fi
}
