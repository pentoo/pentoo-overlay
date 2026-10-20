# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="FluxionNetwork/fluxion"
inherit wrapper github-archive

DESCRIPTION="Security auditing social-engineering tool for WPA/WPA2 networks (evil twin / captive portal)"
HOMEPAGE="https://github.com/FluxionNetwork/fluxion"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# All runtime dependencies are provided by portage. Fluxion's built-in
# installer (-i/--install), its remote self-updater and its system-service
# mutation are disabled via patch: under Gentoo a tool must never install,
# download or modify anything itself.
PDEPEND="
	app-alternatives/awk
	app-alternatives/bc
	app-arch/7zip
	app-arch/unzip
	app-misc/tmux
	dev-lang/php[cgi]
	dev-libs/openssl
	net-analyzer/dsniff
	net-analyzer/macchanger
	net-analyzer/nmap
	net-firewall/iptables
	net-misc/curl
	net-misc/kea
	net-wireless/aircrack-ng
	net-wireless/cowpatty
	net-wireless/hostapd
	net-wireless/iw
	net-wireless/mdk4
	sys-apps/net-tools
	sys-apps/util-linux
	sys-process/psmisc
	www-servers/lighttpd
	x11-terms/xterm
"

src_prepare() {
	default
	eapply "${FILESDIR}/${P}-no-self-install.patch"
}

src_install() {
	make_wrapper fluxion ./fluxion.sh /usr/share/${PN} "" /usr/sbin
	insinto /usr/share/${PN}
	doins -r attacks language lib logos scripts
	exeinto /usr/share/${PN}
	doexe fluxion.sh
	keepdir /usr/share/${PN}/preferences
}
