# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="bash script for Linux systems to audit wireless networks"
HOMEPAGE="https://github.com/v1s1t0r1sh3r3/airgeddon"
SRC_URI="https://github.com/v1s1t0r1sh3r3/airgeddon/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="opencl"

DEPEND=""
RDEPEND=""
BDEPEND=""
#no keywords?
#www-apps/beef
PDEPEND=">=app-shells/bash-4.2
		virtual/awk
		net-wireless/aircrack-ng
		x11-terms/xterm
		sys-apps/iproute2
		sys-apps/pciutils
		sys-process/procps
		net-analyzer/ettercap
		net-analyzer/bettercap
		net-analyzer/wireshark[tshark]
		app-misc/crunch
		net-wireless/hcxdumptool
		net-wireless/hcxtools
		net-wireless/mdk
		net-misc/dhcp
		opencl? ( app-crypt/hashcat )
		net-wireless/hostapd[wpe(+)]
		net-wireless/reaver-wps-fork-t6x
		net-wireless/bully
		net-wireless/pixiewps
		|| ( net-firewall/nftables net-firewall/iptables )
		app-crypt/asleap
		dev-libs/openssl
		x11-apps/xdpyinfo
		sys-apps/ethtool
		sys-apps/usbutils
		sys-apps/util-linux
		net-misc/wget
		app-admin/ccze
		x11-apps/xset"

src_prepare() {
	sed -i "/^AIRGEDDON_AUTO_UPDATE/s/=.*/=false/" .airgeddonrc || die
	sed -i "/^AIRGEDDON_MDK_VERSION/s/=.*/=mdk3/" .airgeddonrc || die
	sed -i "/^AIRGEDDON_SILENT_CHECKS=false/s/=.*/=true/" .airgeddonrc || die
	default
}

src_install() {
	make_wrapper ${PN} ./airgeddon.sh /usr/share/airgeddon "" /usr/sbin
	insinto /usr/share/${PN}
	doins -r language_strings.sh known_pins.db plugins
	exeinto /usr/share/${PN}
	doexe airgeddon.sh
	insinto /usr/share/${PN}/plugins
	insinto /etc
	newins .airgeddonrc airgeddonrc
}

pkg_postinst() {
	einfo "Upstream refused to replace dnisff and some functions are broken."
	einfo "For more details, see the following URL:"
	einfo "https://github.com/v1s1t0r1sh3r3/airgeddon/issues/422"
}
