# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/ntp-fingerprint/ntp-fingerprint-0.1.ebuild,v 1.1.1.1 2006/03/09 21:57:23 grimmlin Exp $

DESCRIPTION="A ntp fingerprinter"
HOMEPAGE=""
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=""

src_install() {
	newbin "${FILESDIR}"/"${PN}".pl "${PN}"
	dodoc "${FILESDIR}"/README.txt
}
