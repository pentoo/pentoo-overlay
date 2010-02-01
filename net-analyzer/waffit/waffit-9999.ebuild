# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit subversion python

DESCRIPTION="web application firewall (waf) scanner"
HOMEPAGE="http://code.google.com/p/waffit/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/beautifulsoup"

ESVN_REPO_URI="http://waffit.googlecode.com/svn/trunk/"

src_install() {
	dobin wafw00f.py
	sed -i "s:libs.evillib:evillib:" "${D}"/usr/bin/wafw00f.py || die "sed failed"
	python_version
	insinto /usr/lib/python$PYVER/
	doins libs/evillib.py
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}
