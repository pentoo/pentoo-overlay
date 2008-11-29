# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs eutils

DESCRIPTION="WLAN tools for breaking 802.11 WEP/WPA keys"
HOMEPAGE="http://www.aircrack-ng.org"
SRC_URI="http://download.aircrack-ng.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="inject"

DEPEND="net-libs/libpcap"

src_test() {
	#./makeivs wep.ivs 11111111111111111111111111 || die 'generating ivs file failed'
	#./aircrack-ng wep.ivs || die 'cracking WEP key failed'
	./aircrack-ng test/wpa.cap -w test/password.lst || die 'cracking WPA key failed'
}

src_compile() {
	emake -e CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	make prefix=/usr docdir="/usr/share/doc/${PF}" mandir="/usr/share/man/man1" destdir="${D}" install doc \
		|| die "make install failed"
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	if use inject; then
		epatch "${FILESDIR}/${P}-ipw2200-inject.patch"
		epatch "${FILESDIR}/airodump-ng-${PV}-rtap.patch"
	fi
}
