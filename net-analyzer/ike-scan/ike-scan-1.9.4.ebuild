# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A utility for finding, fingerprinting and testing IKE VPN servers"
HOMEPAGE="http://www.nta-monitor.com/wiki/index.php/Ike-scan_Documentation"
SRC_URI="https://github.com/royhills/ike-scan/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl:0 )"
RDEPEND="${DEPEND}"

src_prepare() {
	# Fix buffer overflow, bug #277556
	sed \
		-e "/MAXLINE/s:255:511:g" \
		-i ike-scan.h || die
	eautoreconf
	eapply_user
}

src_configure() {
	# --disable-lookup prevents ike-scan from phoning home
	# for more information, please see bug 157507
	econf $(use_with ssl openssl) --disable-lookup
}

src_install() {
	default
	dodoc udp-backoff-fingerprinting-paper.txt
}
