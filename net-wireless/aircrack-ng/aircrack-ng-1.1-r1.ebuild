# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit versionator

MY_PV=$(replace_version_separator 2 '-')

DESCRIPTION="WLAN tools for breaking 802.11 WEP/WPA keys"
HOMEPAGE="http://www.aircrack-ng.org"
SRC_URI="http://download.aircrack-ng.org/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

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
	epatch "${FILESDIR}/${P}-respect_LDFLAGS.patch"
	epatch "${FILESDIR}/${PN}-1.0_rc4-fix_build.patch"
	epatch "${FILESDIR}"/diff-wpa-migration-mode-aircrack-ng.diff
}

pkg_setup() {
        # aircrack-ng fails to build with -fPIE.
        filter-flags -fPIE
}

src_compile() {
	emake sqlite=$(have_sqlite) unstable=$(have_unstable) || die "emake failed"
}

src_install() {
	emake \
		prefix="${ROOT}/usr" \
		mandir="${ROOT}/usr/share/man/man1" \
		DESTDIR="${D}" \
		sqlite=$(have_sqlite) \
		unstable=$(have_unstable) \
		install \
		|| die "emake install failed"

	dodoc AUTHORS ChangeLog INSTALLING README
}
