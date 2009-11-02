# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-wireless/btscanner/btscanner-2.1.ebuild,v 1.1.1.1 2006/03/09 22:54:57 grimmlin Exp $

inherit eutils

MY_P="${P/-/_}"

DESCRIPTION="Asmall bluetooth audit suite"
HOMEPAGE="http://www.betaversion.net/btdsd/"
SRC_URI="http://www.betaversion.net/btdsd/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
S="${WORKDIR}/${PN/-/_}"
RDEPEND="net-wireless/bluez"
DEPEND="${RDEPEND}"

src_compile() {
	cd src
	emake || die "emake failed"
}
src_install() {
	dobin src/psm_scan src/rfcomm_scan
	dodoc CHANGELOG README THANKS
}
