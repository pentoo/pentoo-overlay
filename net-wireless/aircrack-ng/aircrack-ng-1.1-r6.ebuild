# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit versionator

MY_PV=$(replace_version_separator 2 '-')

DESCRIPTION="WLAN tools for breaking 802.11 WEP/WPA keys"
HOMEPAGE="http://www.aircrack-ng.org"
SRC_URI="http://download.aircrack-ng.org/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm"

IUSE="kernel_linux kernel_FreeBSD +sqlite +unstable"

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

src_prepare() {
	#backports
	epatch "${FILESDIR}/${P}-respect_LDFLAGS.patch"
	epatch "${FILESDIR}"/diff-wpa-migration-mode-aircrack-ng.diff
	epatch "${FILESDIR}"/ignore-channel-1-error.patch
	epatch "${FILESDIR}"/airodump-ng.ignore-negative-one.v4.patch
	epatch "${FILESDIR}"/pic-fix.patch
	epatch "${FILESDIR}"/changeset_r1921_backport.diff
	epatch "${FILESDIR}"/eapol_fix.patch

	#likely to stay after version bump
	epatch "${FILESDIR}"/airodump-ng-oui-update-path-fix.patch
}

src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getLD)" sqlite=$(have_sqlite) unstable=$(have_unstable) || die "emake failed"
}

src_install() {
	emake \
		prefix="${ROOT}/usr" \
		mandir="${ROOT}/usr/share/man/man1" \
		DESTDIR="${ED}" \
		sqlite=$(have_sqlite) \
		unstable=$(have_unstable) \
		install \
		|| die "emake install failed"

	dodoc AUTHORS ChangeLog INSTALLING README
	dodir /etc/aircrack-ng/
	wget http://standards.ieee.org/regauth/oui/oui.txt -O "${ED}"/etc/aircrack-ng/airodump-ng-oui.txt
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
}
