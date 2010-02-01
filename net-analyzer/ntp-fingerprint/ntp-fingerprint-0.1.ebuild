# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/ntp-fingerprint/ntp-fingerprint-0.1.ebuild,v 1.1.1.1 2006/03/09 21:57:23 grimmlin Exp $

DESCRIPTION="A ntp fingerprinter"
HOMEPAGE="none"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl"

src_install() {
	newbin "${FILESDIR}"/"${PN}".pl "${PN}"
	dodoc "${FILESDIR}"/README.txt
}
