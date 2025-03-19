# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="bash script for Linux systems to audit wireless networks"
HOMEPAGE="https://github.com/v1s1t0r1sh3r3/airgeddon"
SRC_URI="https://github.com/v1s1t0r1sh3r3/airgeddon/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE="opencl"

#no keywords because it doesn't work
#www-apps/beef
PDEPEND="
		app-admin/ccze
		app-alternatives/awk
		app-crypt/asleap
		opencl? ( app-crypt/hashcat )
		app-misc/crunch
		>=app-shells/bash-4.2
		dev-libs/openssl
		|| ( net-firewall/nftables net-firewall/iptables )
		net-analyzer/arping
		net-analyzer/ettercap
		net-analyzer/bettercap
		net-analyzer/wireshark[tshark]
		net-analyzer/tcpdump
		net-dns/dnsmasq
		net-misc/wget
		net-wireless/aircrack-ng
		net-wireless/hcxdumptool
		net-wireless/hcxtools
		net-wireless/mdk
		net-wireless/mdk4
		net-misc/dhcp
		net-wireless/hostapd[wpe(+)]
		net-wireless/reaver-wps-fork-t6x
		net-wireless/bully
		net-wireless/pixiewps
		sys-apps/ethtool
		sys-apps/iproute2
		sys-apps/pciutils
		sys-apps/usbutils
		sys-apps/util-linux
		sys-process/procps
		x11-apps/xdpyinfo
		x11-apps/xset
		x11-terms/xterm
"

src_prepare() {
	sed -i "/^AIRGEDDON_AUTO_UPDATE/s/=.*/=false/" .airgeddonrc || die
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
