# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

MY_P="${PN}_${PV/_rc2/-rc2}"

DESCRIPTION="Web Application Attack and Audit Framework"
HOMEPAGE="http://w3af.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/fpconst-0.7.2
	dev-python/pygoogle
	dev-python/pyPdf
	dev-python/utidylib
	dev-python/soappy
	dev-python/beautifulsoup
	dev-python/pyopenssl
	net-analyzer/scapy"

S="${WORKDIR}/${PN}"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/lib/

	# should be as simple as copying everything into the target...
	cp -pPR "${S}" "${D}"usr/lib/w3af || die

	dobin "${FILESDIR}"/w3af_gui
	dobin "${FILESDIR}"/w3af_console

	chown -R root:0 "${D}"
}
