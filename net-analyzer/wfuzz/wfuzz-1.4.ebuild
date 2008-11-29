# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils
DESCRIPTION="Wfuzz is a tool designed for bruteforcing Web Applications"
HOMEPAGE="http://www.edge-security.com/"
SRC_URI="http://www.edge-security.com/soft/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"
RDEPEND="dev-python/pycurl"

src_compile() {
	elog "Nothing to compile"
}

src_install() {
        dodir /usr/lib/
        dodir /usr/bin/

	dodoc README
	rm COPYING README LICENSES

        # should be as simple as copying everything into the target...
        cp -pPR "${S}" "${D}"usr/lib/wfuzz || die

	dobin "${FILESDIR}"/wfuzz
        chown -R root:0 ${D}

}
