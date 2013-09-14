# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )
inherit subversion distutils-r1

DESCRIPTION="Web application security auditor"
HOMEPAGE="http://wapiti.sourceforge.net/"
ESVN_REPO_URI="http://svn.code.sf.net/p/wapiti/code/trunk/"
ESVN_REVISION="299"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
SLOT="0"

DEPEND=""
RDEPEND=">=dev-python/requests-1.2.3
	dev-python/beautifulsoup:python-2"

src_prepare() {
	sed -e 's|/usr/local/share/|/usr/share/|' -i setup.py
}

#src_install() {
#	insinto /usr/$(get_libdir)/${PN}
#	doins -r src/*
#	chmod +x "${D}/usr/$(get_libdir)/${PN}/${PN}.py"
#	dobin "${FILESDIR}/${PN}"
#	dodoc README
#}

src_install() {
	distutils-r1_src_install
	dosym /usr/bin/${PN}.py /usr/bin/${PN}
}
