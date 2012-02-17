# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit versionator subversion

DESCRIPTION="WLAN tools for breaking 802.11 WEP/WPA keys"
HOMEPAGE="http://www.aircrack-ng.org"
SRC_URI=""
#http://download.aircrack-ng.org/${PN}-${MY_PV}.tar.gz"

ESVN_REPO_URI="http://trac.aircrack-ng.org/svn/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"

IUSE="+airdrop-ng +airgraph-ng kernel_linux kernel_FreeBSD +sqlite +unstable"

DEPEND="dev-libs/openssl
		sqlite? ( >=dev-db/sqlite-3.4 )"
RDEPEND="${DEPEND}
		kernel_linux? ( net-wireless/iw net-wireless/wireless-tools )"

S="${WORKDIR}/${PN}-${MY_PV}"

have_sqlite() {
	use sqlite && echo "true" || echo "false"
}

have_unstable() {
	use unstable && echo "true" || echo "false"
}

subversion_src_prepare() {
	subversion_bootstrap || die "${ESVN}: unknown problem occurred in subversion_bootstrap."
}

src_prepare() {
	#make aircrack-ng respect prefix for install
	#rewrite this to a sed line
	epatch "${FILESDIR}"/airodump-ng-oui-update-path-fix.patch
}


src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getLD)" sqlite=$(have_sqlite) unstable=$(have_unstable)
}

src_install() {
	emake \
		prefix="${ED}/usr" \
		sqlite=$(have_sqlite) \
		unstable=$(have_unstable) \
		install \

	dodoc AUTHORS ChangeLog INSTALLING README
	dodir /etc/aircrack-ng/
	wget http://standards.ieee.org/regauth/oui/oui.txt -O "${ED}"/etc/aircrack-ng/airodump-ng-oui.txt

	if use airgraph-ng; then
		cd "${S}/scripts/airgraph-ng"
		emake prefix="${ED}/usr" install
	fi
	if use airdrop-ng; then
		cd "${S}/scripts/airdrop-ng"
		emake prefix="${ED}/usr" install
	fi
}

pkg_postinst() {
	# Message is (c) FreeBSD
	# http://www.freebsd.org/cgi/cvsweb.cgi/ports/net-mgmt/aircrack-ng/files/pkg-message.in?rev=1.5
	if use kernel_FreeBSD ; then
		einfo "Contrary to Linux, it is not necessary to use airmon-ng to enable the monitor"
		einfo "mode of your wireless card.  So do not care about what the manpages say about"
		einfo "airmon-ng, airodump-ng sets monitor mode automatically."
		echo
		einfo "To return from monitor mode, issue the following command:"
		einfo "    ifconfig \${INTERFACE} -mediaopt monitor"
		einfo
		einfo "For aireplay-ng you need FreeBSD >= 7.0."
	fi
	einfo "Run 'airodump-ng-oui-update' as root to install or update OUI file"
}
