# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs savedconfig

DESCRIPTION="Evil client portion of EAP relay attack"
HOMEPAGE="https://w1f1.net https://github.com/sensepost/wpa_sycophant"

if [[ $PV == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sensepost/wpa_sycophant.git"
else
	SRC_URI="https://github.com/sensepost/wpa_sycophant/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
IUSE="bindist ssl"

RDEPEND="
	dev-libs/libnl:3
	net-misc/dhcp[client]
	net-wireless/crda
	net-wireless/hostapd-mana
	ssl? ( dev-libs/openssl:0=[bindist=] )
	!ssl? ( dev-libs/libtommath )"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${P}/wpa_supplicant"

Kconfig_style_config() {
		#param 1 is CONFIG_* item
		#param 2 is what to set it = to, defaulting in y
		CONFIG_PARAM="${CONFIG_HEADER:-CONFIG_}$1"
		setting="${2:-y}"

		if [ ! $setting = n ]; then
			#first remove any leading "# " if $2 is not n
			sed -i "/^# *$CONFIG_PARAM=/s/^# *//" .config || echo "Kconfig_style_config error uncommenting $CONFIG_PARAM"
			#set item = $setting (defaulting to y)
			sed -i "/^$CONFIG_PARAM/s/=.*/=$setting/" .config || echo "Kconfig_style_config error setting $CONFIG_PARAM=$setting"
			if [ -z "$( grep ^$CONFIG_PARAM= .config )" ] ; then
				echo "$CONFIG_PARAM=$setting" >> .config || die
			fi
		else
			#ensure item commented out
			sed -i "/^$CONFIG_PARAM/s/$CONFIG_PARAM/# $CONFIG_PARAM/" .config || echo "Kconfig_style_config error commenting $CONFIG_PARAM"
		fi
}

src_prepare() {
	# net/bpf.h needed for net-libs/libpcap on Gentoo/FreeBSD
	sed -e "s:\(#include <pcap\.h>\):#include <net/bpf.h>\n\1:" \
		-i ../src/l2_packet/l2_packet_freebsd.c || die

	# People seem to take the example configuration file too literally (bug #102361)
	sed -e "s:^\(opensc_engine_path\):#\1:" \
		-e "s:^\(pkcs11_engine_path\):#\1:" \
		-e "s:^\(pkcs11_module_path\):#\1:" \
		-i wpa_supplicant.conf || die

	# Change configuration to match Gentoo locations (bug #143750)
	sed -e "s:/usr/lib/opensc:/usr/$(get_libdir):" \
		-e "s:/usr/lib/pkcs11:/usr/$(get_libdir):" \
		-i wpa_supplicant.conf || die

	sed -e 's#-Werror ##' \
		-i Makefile || die

	# Allow users to apply patches to src/drivers for example,
	# i.e. anything outside ${S}
	pushd ../ >/dev/null || die

	eapply "${FILESDIR}"/wpa_sycophant_pentoo.patch
	default

	popd >/dev/null || die
}

src_configure() {
	# Toolchain setup
	tc-export CC

	restore_config .config

	# Basic setup
	Kconfig_style_config CTRL_IFACE
	Kconfig_style_config MATCH_IFACE
	Kconfig_style_config BACKEND file
	Kconfig_style_config IBSS_RSN
	Kconfig_style_config IEEE80211W
	Kconfig_style_config IEEE80211R

	# Enabling background scanning.
	Kconfig_style_config BGSCAN_SIMPLE
	Kconfig_style_config BGSCAN_LEARN

	# Enable support for writing debug info to a log file and syslog.
	Kconfig_style_config DEBUG_FILE
	Kconfig_style_config DEBUG_SYSLOG

	# SSL authentication methods
	if use ssl; then
		Kconfig_style_config SUITEB192
		Kconfig_style_config TLS openssl
		if ! use bindist; then
			Kconfig_style_config EAP_PWD
			Kconfig_style_config MESH
			#WPA3
			Kconfig_style_config OWE
			Kconfig_style_config SAE
		fi
	else
		Kconfig_style_config TLS internal
	fi
}

src_compile() {
	emake V=1 wpa_supplicant
}

src_install() {
	exeinto "/usr/share/${PN}"
	doexe wpa_supplicant

	pushd ../ >/dev/null || die

	insinto "/etc/${PN}"
	doins wpa_sycophant_example.conf

	insinto "/etc/hostapd-mana"
	doins "${FILESDIR}"/hostapd-mana.conf

	newsbin wpa_sycophant.sh wpa_sycophant

	dodoc wpa_sycophant_example.conf README*

	popd >/dev/null || die

	save_config .config
}

pkg_postinst() {
	ewarn "\nIf this is a clean installation of ${PN}, you"
	ewarn "have to create a configuration file named"
	ewarn "${EROOT%/}/etc/${PN}/wpa_sycophant.conf"
	ewarn "An example configuration file is available for reference in"
	ewarn "${EROOT%/}/usr/share/doc/${PF}/\n"
}
