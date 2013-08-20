# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2"

inherit subversion python

DESCRIPTION="Web application security auditor"
HOMEPAGE="http://wapiti.sourceforge.net/"
ESVN_REPO_URI="http://svn.code.sf.net/p/wapiti/code/trunk/"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""
SLOT="0"

DEPEND=""
RDEPEND="dev-python/requests
	dev-python/beautifulsoup:python-2"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	insinto /usr/$(get_libdir)/${PN}
	doins -r src/*
	chmod +x "${D}/usr/$(get_libdir)/${PN}/${PN}.py"
#	dosym "/usr/$(get_libdir)/${PN}/${PN}.py" /usr/bin/"${PN}"
	dobin "${FILESDIR}/${PN}"
	dodoc README
}
