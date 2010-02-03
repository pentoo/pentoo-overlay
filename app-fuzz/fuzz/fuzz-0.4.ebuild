# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuzz/fuzzer/fuzzer-1.2.ebuild,v 1.1.1.1 2006/03/12 23:52:44 grimmlin Exp $

DESCRIPTION="Python based fuzzer for multi protocols, and faultinject"
HOMEPAGE="http://taviso.decsystem.org/software.html#toc2"
SRC_URI="http://taviso.decsystem.org/files/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""

src_compile () {
	emake PREFIX="/usr"
}

src_install () {
	dobin fuzz
	insinto /usr/lib/fuzz
	insopts -m 0755
	doins builtins.so
	insopts -m 0644
	doins define.sh util.sh init.sh decay.sh
	dodoc README README.html TODO ChangeLog
}
