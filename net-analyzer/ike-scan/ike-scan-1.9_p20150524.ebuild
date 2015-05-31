# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ike-scan/ike-scan-1.9-r1.ebuild,v 1.1 2012/06/18 02:09:59 jer Exp $

EAPI=4

inherit git-2 autotools

DESCRIPTION="A utility for finding, fingerprinting and testing IKE VPN servers"
HOMEPAGE="http://www.nta-monitor.com/tools-resources/security-tools/ike-scan"
EGIT_REPO_URI="https://github.com/royhills/ike-scan.git"
EGIT_COMMIT="4cc8134954b690496583fcb874b7406bb081076a"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

src_prepare() {
	# Fix buffer overflow, bug #277556
	sed \
		-e "/MAXLINE/s:255:511:g" \
		-i ike-scan.h || die
	eautoreconf
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
