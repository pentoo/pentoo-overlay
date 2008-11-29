# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuzz/snmp-fuzzer/snmp-fuzzer-0.1.1.ebuild,v 1.1.1.1 2006/03/09 22:54:57 grimmlin Exp $

DESCRIPTION="A very complete snmp fuzzer"
HOMEPAGE="http://www.arhont.com/"
SRC_URI="http://www.pentoo.ch/distfiles/snmp-fuzzer-0.1.1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	dodoc README.txt TODO CHANGELOG.txt
	rm README.txt TODO CHANGELOG.txt LICENSE.TXT
	insinto /opt/snmp-fuzzer/
	doins -r *
	dosbin "${FILESDIR}"/snmp-fuzzer
}
