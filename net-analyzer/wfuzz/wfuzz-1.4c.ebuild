# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Wfuzz is a tool designed for bruteforcing Web Applications"
HOMEPAGE="http://www.edge-security.com/wfuzz.php"
SRC_URI="http://www.edge-security.com/soft/${P}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pycurl"

S=${WORKDIR}/${PN}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/lib/
	dodir /usr/bin/

	dodoc README
	rm COPYING README LICENSES

	# should be as simple as copying everything into the target...
	cp -pPR "${S}" "${D}"usr/lib/wfuzz || die

	dobin "${FILESDIR}"/wfuzz
	chown -R root:0 "${D}"

}
