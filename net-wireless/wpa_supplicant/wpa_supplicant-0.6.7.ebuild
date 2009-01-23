# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wpa_supplicant/wpa_supplicant-0.6.4.ebuild,v 1.1 2008/08/19 13:03:50 rbu Exp $

EAPI="1"

inherit eutils toolchain-funcs

DESCRIPTION="IEEE 802.1X/WPA supplicant for secure wireless transfers"
HOMEPAGE="http://hostap.epitest.fi/wpa_supplicant/"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz"
LICENSE="|| ( GPL-2 BSD )"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="dbus debug gnutls gsm madwifi qt3 qt4 readline ssl kernel_linux
	kernel_FreeBSD ps3"

RDEPEND="dbus? ( sys-apps/dbus )
		kernel_linux? (
			gsm? ( sys-apps/pcsc-lite )
		 	madwifi? ( ||
				( net-wireless/madwifi-hal-tools
				net-wireless/madwifi-old )
			)
		)
		!kernel_linux? ( net-libs/libpcap )
		qt4? (
			|| ( ( x11-libs/qt-core:4
					x11-libs/qt-gui:4 )
					<x11-libs/qt-4.4:4
			)
		)
		!qt4? ( qt3? ( =x11-libs/qt-3* ) )
		readline? ( sys-libs/ncurses sys-libs/readline )
		ssl? ( dev-libs/openssl )
		gnutls? ( net-libs/gnutls )
		!ssl? ( !gnutls? ( dev-libs/libtommath ) )"

S="${WORKDIR}/${P}/${PN}"

pkg_setup() {
	if use qt3 && use qt4; then
		einfo "You have USE=\"qt3 qt4\" selected, defaulting to USE=\"qt4\""
	fi

	if use qt4 && has_version ">=x11-libs/qt-4.2.2" ; then
		if ! built_with_use x11-libs/qt qt3support ; then
			eerror ">=qt4.2.2 requires qt3support"
			die "rebuild >=x11-libs/qt-4.2.2 with the qt3support USE flag"
		fi
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"

	# net/bpf.h needed for net-libs/libpcap on Gentoo FreeBSD
	sed -i \
		-e "s:\(#include <pcap\.h>\):#include <net/bpf.h>\n\1:" \
		../src/l2_packet/l2_packet_freebsd.c || die

	# toolchain setup
	echo "CC = $(tc-getCC)" > .config

	# basic setup
	echo "CONFIG_CTRL_IFACE=y" >> .config
	echo "CONFIG_BACKEND=file" >> .config

	# basic authentication methods
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
		# smart card authentication
		echo "CONFIG_EAP_SIM=y" >> .config
		echo "CONFIG_EAP_AKA=y" >> .config
		echo "CONFIG_PCSC=y"    >> .config
	fi

	if use readline ; then
		# readline/history support for wpa_cli
		echo "CONFIG_READLINE=y" >> .config
	fi

	# SSL authentication methods
	if use gnutls ; then
		echo "CONFIG_TLS=gnutls" >> .config
		echo "CONFIG_GNUTLS_EXTRA=y" >> .config
	elif use ssl ; then
		echo "CONFIG_TLS=openssl" >> .config
		echo "CONFIG_SMARTCARD=y" >> .config
	else
		echo "CONFIG_TLS=internal" >> .config
	fi

	if use kernel_linux ; then
		# Linux specific drivers
		echo "CONFIG_DRIVER_ATMEL=y"       >> .config
		#echo "CONFIG_DRIVER_BROADCOM=y"   >> .config
		#echo "CONFIG_DRIVER_HERMES=y"	   >> .config
		echo "CONFIG_DRIVER_HOSTAP=y"      >> .config
		echo "CONFIG_DRIVER_IPW=y"         >> .config
		echo "CONFIG_DRIVER_NDISWRAPPER=y" >> .config
		echo "CONFIG_DRIVER_PRISM54=y"     >> .config
		echo "CONFIG_DRIVER_WEXT=y"        >> .config
		echo "CONFIG_DRIVER_WIRED=y"       >> .config

		if use madwifi ; then
			# Add include path for madwifi-driver headers
			echo "CFLAGS += -I/usr/include/madwifi" >> .config
			echo "CONFIG_DRIVER_MADWIFI=y"                 >> .config
		fi
		if use ps3 ; then
			echo "CONFIG_DRIVER_PS3=y" >> .config
		fi
	elif use kernel_FreeBSD ; then
		# FreeBSD specific driver
		echo "CONFIG_DRIVER_BSD=y" >> .config
	fi

	# people seem to take the example configuration file too literally
	# bug #102361
	sed -i \
		-e "s:^\(opensc_engine_path\):#\1:" \
		-e "s:^\(pkcs11_engine_path\):#\1:" \
		-e "s:^\(pkcs11_module_path\):#\1:" \
		wpa_supplicant.conf || die

	# Change configuration to match Gentoo locations, #143750
	sed -i \
		-e "s:/usr/lib/opensc:/usr/$(get_libdir):" \
		-e "s:/usr/lib/pkcs11:/usr/$(get_libdir):" \
		wpa_supplicant.conf || die
}

src_compile() {
	emake || die "emake failed"

	if use qt4 ; then
		qmake -o "${S}"/wpa_gui-qt4/Makefile "${S}"/wpa_gui-qt4/wpa_gui.pro
		cd "${S}"/wpa_gui-qt4
		emake || die "emake wpa_gui-qt4 failed"
	elif use qt3 ; then
		[[ -d "${QTDIR}"/etc/settings ]] && addwrite "${QTDIR}"/etc/settings
		"${QTDIR}"/bin/qmake -o "${S}"/wpa_gui/Makefile "${S}"/wpa_gui/wpa_gui.pro
		cd "${S}"/wpa_gui
		emake || die "emake wpa_gui failed"
	fi
}

src_install() {
	dosbin wpa_supplicant
	dobin wpa_cli wpa_passphrase

	# baselayout-1 compat
	dosym /usr/sbin/wpa_supplicant /sbin/wpa_supplicant
	dosym /usr/bin/wpa_cli /bin/wpa_cli

	exeinto /etc/wpa_supplicant/
	newexe "${FILESDIR}"/wpa_cli.sh wpa_cli.sh
	insinto /etc/wpa_supplicant/
	newins "${FILESDIR}"/wpa_supplicant.conf wpa_supplicant.conf

	dodoc ChangeLog eap_testing.txt README todo.txt
	newdoc wpa_supplicant.conf wpa_supplicant.conf

	doman doc/docbook/*.8
	doman doc/docbook/*.5

	if use qt4 ; then
		into /usr
		dobin wpa_gui-qt4/wpa_gui
	elif use qt3 ; then
		into /usr
		dobin wpa_gui/wpa_gui
	fi

	if use qt3 || use qt4; then
		make_desktop_entry wpa_gui "WPA_Supplicant Administration GUI"
	fi

	if use dbus ; then
		insinto /etc/dbus-1/system.d
		newins dbus-wpa_supplicant.conf wpa_supplicant.conf
		insinto /usr/share/dbus-1/system-services
		newins dbus-wpa_supplicant.service 'fi.epitest.hostap.WPASupplicant.service'
		keepdir /var/run/wpa_supplicant
	fi
}

pkg_postinst() {
	einfo "A default configuration file has been installed to"
	einfo "/etc/wpa_supplicant/wpa_supplicant.conf"
	einfo
	einfo "An example configuration file is available as"
	einfo "/usr/share/doc/${PF}/wpa_supplicant.conf.gz"

	if [[ -e ${ROOT}etc/wpa_supplicant.conf ]] ; then
		echo
		ewarn "WARNING: your old configuration file ${ROOT}etc/wpa_supplicant.conf"
		ewarn "needs to be moved to ${ROOT}etc/wpa_supplicant/wpa_supplicant.conf"
	fi

	if use madwifi; then
		echo
		einfo "This package compiles against the headers installed by"
		einfo "madwifi-old, madwifi-ng or madwifi-ng-tools."
		einfo "You should remerge ${PN} after upgrading these packages."
	fi
}
