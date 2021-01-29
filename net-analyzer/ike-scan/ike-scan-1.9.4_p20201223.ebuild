# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="A utility for finding, fingerprinting and testing IKE VPN servers"
HOMEPAGE="http://www.nta-monitor.com/wiki/index.php/Ike-scan_Documentation"
HASH_COMMIT="b85ea4cf0f0b850ca2eba4397ae985e0ab0a874b"
SRC_URI="https://github.com/royhills/ike-scan/archive/${HASH_COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="libressl ssl"

DEPEND="
	ssl? (
		!libressl? ( dev-libs/openssl:0= )
		libressl? ( dev-libs/libressl:0= )
	)
"
RDEPEND="
	${DEPEND}
"

S=${WORKDIR}/${PN}-${HASH_COMMIT}

src_prepare() {
	# Fix buffer overflow, bug #277556
	sed \
		-e "/MAXLINE/s:255:511:g" \
		-i ike-scan.h || die

	default

	eautoreconf
}

src_configure() {
	econf $(use_with ssl openssl)
}

src_install() {
	default
	dodoc udp-backoff-fingerprinting-paper.txt
}
