# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuzz/Peach/Peach-0.4.ebuild,v 1.1.1.2 2006/03/13 21:42:50 grimmlin Exp $

inherit distutils python

DESCRIPTION="A generic fuzzer framework"
HOMEPAGE="http://taof.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.4
	 dev-python/pygtk
	 dev-python/twisted"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	insinto /usr/lib/"${PN}"
	doins -r *
	dodoc Changelog
	dosbin "${FILESDIR}"/taof
}
