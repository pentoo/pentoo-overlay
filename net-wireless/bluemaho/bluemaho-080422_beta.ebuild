# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-wireless/btscanner/btscanner-2.1.ebuild,v 1.1.1.1 2006/03/09 22:54:57 grimmlin Exp $

inherit eutils

MY_P="${PN}_v${PV}"

DESCRIPTION="BlueMaho is GUI-shell (interface) for suite of tools for testing security of bluetooth devices"
HOMEPAGE="http://wiki.thc.org/BlueMaho"
SRC_URI="http://wiki.thc.org/BlueMaho?action=AttachFile&do=get&target=${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
S="${WORKDIR}/${MY_P}"
RDEPEND="net-wireless/bluez-utils
	 net-wireless/bt-audit"
DEPEND="${RDEPEND}"

src_compile() {
	if ! ( built_with_use test-programs net-wireless/bluez-utils ) ; then
		eerror "net-wireless/bluez-utils must be built with USE=\"test-programs\""
		die "Dependencies not met"
	fi
	cd src
	emake || die "emake failed"
}
src_install() {
	dobin src/psm_scan src/rfcomm_scan
	dodoc CHANGELOG README THANKS
}
