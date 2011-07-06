# Copyright 1999-2010 Gentoo Foundation
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

IUSE="+sqlite +unstable"

DEPEND="dev-libs/openssl
		sqlite? ( >=dev-db/sqlite-3.4 )"
RDEPEND="${DEPEND}
	net-wireless/iw"

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
