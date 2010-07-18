# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit distutils subversion

DESCRIPTION="Web Application Attack and Audit Framework"
HOMEPAGE="http://w3af.sourceforge.net/"
ESVN_REPO_URI="https://w3af.svn.sourceforge.net/svnroot/w3af/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
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

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/lib/
	# should be as simple as copying everything into the target...
	cp -pPR "${S}" "${D}"usr/lib/w3af || die
	if use gtk; then
		dobin "${FILESDIR}"/w3af_gui
	fi
	dobin "${FILESDIR}"/w3af_console
	chown -R root:0 "${D}"
}
