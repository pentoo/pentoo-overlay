# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils

DESCRIPTION="Web Application Attack and Audit Framework"
HOMEPAGE="http://w3af.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk"

DEPEND=""
RDEPEND=">=dev-python/fpconst-0.7.2
	dev-python/pygoogle-ajax
	dev-python/pyPdf
	dev-python/utidylib
	dev-python/soappy
	dev-python/beautifulsoup
	dev-python/pyopenssl
	net-analyzer/scapy
	gtk? ( dev-python/pygtk )"

S="${WORKDIR}/${PN}"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/lib/

	# should be as simple as copying everything into the target...
	cp -pPR "${S}" "${D}"usr/lib/w3af || die

	if use gtk; then
		dobin "${FILESDIR}"/w3af_gui || die
	fi
	dobin "${FILESDIR}"/w3af_console || die

	chown -R root:0 "${D}"
}
